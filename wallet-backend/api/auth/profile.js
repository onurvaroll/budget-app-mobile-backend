const express = require('express');
const pool = require('../../db');
const authenticateToken = require('../../middleware/middleware');

const router = express.Router();

// Kullanıcı profilini getir
router.get('/profile', authenticateToken, async (req, res) => {
  try {
    const result = await pool.query('SELECT id, name, email, profile_picture, first_name, last_name FROM users WHERE id = $1', [req.userId]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Kullanıcı bulunamadı.' });
    }
    const user = result.rows[0];
    res.json({ 
      user: {
        id: user.id,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        profile_photo: user.profile_picture
      }
    });
  } catch (err) {
    console.error('Get profile error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

// Kullanıcı profilini güncelle
router.put('/profile', authenticateToken, async (req, res) => {
  const { name } = req.body;
  if (!name) return res.status(400).json({ error: 'İsim zorunlu.' });
  try {
    const result = await pool.query(
      'UPDATE users SET name = $1 WHERE id = $2 RETURNING id, name, email',
      [name, req.userId]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Kullanıcı bulunamadı.' });
    }
    res.json({ user: result.rows[0] });
  } catch (err) {
    console.error('Update profile error:', err);
    res.status(500).json({ error: 'Sunucu hatası.', details: err.message });
  }
});

module.exports = router;
