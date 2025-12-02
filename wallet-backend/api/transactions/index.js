const express = require('express');
const pool = require('../../db');
const authenticateToken = require('../../middleware/middleware');

const router = express.Router();

// GET /api/transactions - İşlemleri getir (Filtreleme ve Sayfalama ile)
router.get('/', authenticateToken, async (req, res) => {
  try {
    const { startDate, endDate, type, category_id, page = 1, limit = 10 } = req.query;
    const offset = (page - 1) * limit;

    let query = 'SELECT * FROM transactions WHERE user_id = $1';
    const params = [req.userId];
    let paramIndex = 2;

    if (startDate) {
      query += ` AND date >= $${paramIndex}`;
      params.push(startDate);
      paramIndex++;
    }

    if (endDate) {
      query += ` AND date <= $${paramIndex}`;
      params.push(endDate);
      paramIndex++;
    }

    if (type) {
      query += ` AND type = $${paramIndex}`;
      params.push(type);
      paramIndex++;
    }

    if (category_id) {
      query += ` AND category_id = $${paramIndex}`;
      params.push(category_id);
      paramIndex++;
    }

    // Toplam kayıt sayısını al (Pagination için)
    const countQuery = query.replace('SELECT *', 'SELECT COUNT(*)');
    const countResult = await pool.query(countQuery, params);
    const total = parseInt(countResult.rows[0].count);

    // Sıralama ve Sayfalama
    query += ` ORDER BY date DESC LIMIT $${paramIndex} OFFSET $${paramIndex + 1}`;
    params.push(limit, offset);

    const result = await pool.query(query, params);

    res.json({
      transactions: result.rows,
      total,
      page: parseInt(page),
      totalPages: Math.ceil(total / limit)
    });
  } catch (err) {
    console.error('Get transactions error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

// GET /api/transactions/summary - İşlem özetini getir
router.get('/summary', authenticateToken, async (req, res) => {
  try {
    const { startDate, endDate } = req.query;
    let query = `
      SELECT 
        SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END) as income,
        SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END) as expense
      FROM transactions 
      WHERE user_id = $1
    `;
    const params = [req.userId];
    let paramIndex = 2;

    if (startDate) {
      query += ` AND date >= $${paramIndex}`;
      params.push(startDate);
      paramIndex++;
    }

    if (endDate) {
      query += ` AND date <= $${paramIndex}`;
      params.push(endDate);
      paramIndex++;
    }

    const result = await pool.query(query, params);
    const income = parseFloat(result.rows[0].income || 0);
    const expense = parseFloat(result.rows[0].expense || 0);

    res.json({
      income,
      expense,
      balance: income - expense
    });
  } catch (err) {
    console.error('Get summary error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

// GET /api/transactions/{id} - İşlem detayını getir
router.get('/:id', authenticateToken, async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      'SELECT * FROM transactions WHERE id = $1 AND user_id = $2',
      [id, req.userId]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'İşlem bulunamadı.' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error('Get transaction detail error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

// POST /api/transactions - Yeni işlem oluştur
router.post('/', authenticateToken, async (req, res) => {
  const { amount, type, description, date, category_id } = req.body;
  
  // title alanı veritabanında NOT NULL ise geçici bir değer verelim veya description kullanalım
  // İstenen yapıda title yok ama veritabanında var. Description'ı title olarak da kullanabiliriz.
  const title = description || 'İşlem'; 

  if (!amount || !type) {
    return res.status(400).json({ error: 'Tutar ve tip zorunlu.' });
  }
  try {
    const result = await pool.query(
      'INSERT INTO transactions (title, amount, type, date, category_id, description, user_id) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *',
      [title, amount, type, date || new Date(), category_id, description, req.userId]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error('Add transaction error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

// PUT /api/transactions/{id} - İşlem güncelle
router.put('/:id', authenticateToken, async (req, res) => {
  const { id } = req.params;
  const { amount, description, date, category_id } = req.body;
  
  try {
    // Dinamik update sorgusu oluştur
    let fields = [];
    let params = [id, req.userId];
    let paramIndex = 3;

    if (amount !== undefined) {
      fields.push(`amount = $${paramIndex}`);
      params.push(amount);
      paramIndex++;
    }
    if (description !== undefined) {
      fields.push(`description = $${paramIndex}`);
      // title'ı da description ile güncelleyelim tutarlılık için
      fields.push(`title = $${paramIndex}`); 
      params.push(description);
      paramIndex++;
    }
    if (date !== undefined) {
      fields.push(`date = $${paramIndex}`);
      params.push(date);
      paramIndex++;
    }
    if (category_id !== undefined) {
      fields.push(`category_id = $${paramIndex}`);
      params.push(category_id);
      paramIndex++;
    }

    if (fields.length === 0) {
      return res.status(400).json({ error: 'Güncellenecek veri yok.' });
    }

    const query = `UPDATE transactions SET ${fields.join(', ')} WHERE id = $1 AND user_id = $2 RETURNING *`;
    const result = await pool.query(query, params);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'İşlem bulunamadı veya yetkiniz yok.' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error('Update transaction error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

// DELETE /api/transactions/{id} - İşlem sil
router.delete('/:id', authenticateToken, async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      'DELETE FROM transactions WHERE id = $1 AND user_id = $2 RETURNING *',
      [id, req.userId]
    );
    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'İşlem bulunamadı veya yetkiniz yok.' });
    }
    res.json({ message: 'İşlem silindi.' });
  } catch (err) {
    console.error('Delete transaction error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

module.exports = router;
