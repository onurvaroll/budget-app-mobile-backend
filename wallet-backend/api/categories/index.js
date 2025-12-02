const express = require('express');
const pool = require('../../db');
const authenticateToken = require('../../middleware/middleware');

const router = express.Router();

// Kategori Ekle
router.post('/', authenticateToken, async (req, res) => {
  const { name, type, icon } = req.body;
  if (!name || !type) {
    return res.status(400).json({ error: 'İsim ve tip zorunlu.' });
  }
  try {
    const result = await pool.query(
      'INSERT INTO categories (name, type, icon, user_id, is_system) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [name, type, icon, req.userId, false] // is_system default false
    );
    // Flutter modeli direkt obje bekliyor olabilir, veya { category: ... }
    // Verdiğin örnekte POST response body'si net değil ama GET array dönüyor.
    // Genelde REST API'ler oluşturulan objeyi döner.
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error('Add category error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

// Kategorileri Listele
router.get('/', authenticateToken, async (req, res) => {
  try {
    // Hem kullanıcının kendi kategorilerini hem de sistem kategorilerini getir
    const result = await pool.query(
      'SELECT * FROM categories WHERE user_id = $1 OR is_system = TRUE ORDER BY id DESC',
      [req.userId]
    );
    // Flutter tarafı List<AppCategory> bekliyor, bu yüzden direkt array dönüyoruz
    res.json(result.rows);
  } catch (err) {
    console.error('Get categories error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

// Kategori Güncelle
router.put('/:id', authenticateToken, async (req, res) => {
  const { id } = req.params;
  const { name, icon } = req.body;
  if (!name) {
    return res.status(400).json({ error: 'İsim zorunlu.' });
  }
  try {
    // Sadece kendi kategorisini güncelleyebilir (is_system=false kontrolü de eklenebilir ama user_id kontrolü yeterli)
    const result = await pool.query(
      'UPDATE categories SET name = $1, icon = $2, updated_at = CURRENT_TIMESTAMP WHERE id = $3 AND user_id = $4 RETURNING *',
      [name, icon, id, req.userId]
    );
    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Kategori bulunamadı veya yetkiniz yok.' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error('Update category error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

// Kategori Sil
router.delete('/:id', authenticateToken, async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      'DELETE FROM categories WHERE id = $1 AND user_id = $2 RETURNING *',
      [id, req.userId]
    );
    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Kategori bulunamadı veya yetkiniz yok.' });
    }
    res.json({ message: 'Kategori silindi.' });
  } catch (err) {
    console.error('Delete category error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

module.exports = router;
