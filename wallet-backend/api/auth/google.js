const express = require('express');
const jwt = require('jsonwebtoken');
const { OAuth2Client } = require('google-auth-library');
const pool = require('../../db');

const router = express.Router();
const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

// Google ile giriş
router.post('/google', async (req, res) => {
  const { token } = req.body;
  
  console.log('------------------------------------------------');
  console.log('Google Login İsteği Alındı');
  console.log('Token Uzunluğu:', token ? token.length : 0);
  if (!token) return res.status(400).json({ message: 'ID Token is required' });

  try {
    const ticket = await client.verifyIdToken({
      idToken: token,
      audience: process.env.GOOGLE_CLIENT_ID,
    });
    
    const payload = ticket.getPayload();
    
    // 1. Google'dan gelen verileri doğru değişkenlere alıyoruz
    // Google "name" yerine "given_name" (Ad) ve "family_name" (Soyad) verir.
    // "picture" ise profil fotoğrafıdır.
    const { 
      sub: googleId, 
      email, 
      given_name, // Google'daki Ad
      family_name, // Google'daki Soyad
      picture // Google'daki Profil Fotosu
    } = payload;

    // Kullanıcı var mı kontrolü
    let userResult = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    let user;

    if (userResult.rows.length === 0) {
      // 2. YENİ KULLANICI KAYDI:
      const insert = await pool.query(
        `INSERT INTO users (first_name, last_name, email, profile_picture, password_hash, name) 
         VALUES ($1, $2, $3, $4, $5, $6) 
         RETURNING *`,
        [given_name, family_name, email, picture, googleId, `${given_name} ${family_name}`]
      );
      user = insert.rows[0];
    } else {
      // 3. MEVCUT KULLANICI GÜNCELLEME:
      const update = await pool.query(
        `UPDATE users 
         SET first_name = $1, last_name = $2, profile_picture = $3 
         WHERE email = $4 
         RETURNING *`,
        [given_name, family_name, picture, email]
      );
      
      user = update.rows[0];
    }

    const jwtToken = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '7d' });

    // Swagger'daki response yapına uygun dönüş
    res.json({ 
      token: jwtToken, 
      user: user 
    });

  } catch (err) {
    console.error('Google login error:', err);
    res.status(401).json({ 
      message: 'Invalid token', 
      error: err.message 
    });
  }
});

module.exports = router;
