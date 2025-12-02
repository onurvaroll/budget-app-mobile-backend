const express = require('express');
const cors = require('cors');
const path = require('path');
const pool = require('./db');
require('dotenv').config();

process.on('uncaughtException', (err) => {
  console.error('UNCAUGHT EXCEPTION:', err);
});

process.on('unhandledRejection', (reason, p) => {
  console.error('UNHANDLED REJECTION:', reason);
});

const authRoutes = require('./api/auth');
const googleAuth = require('./api/auth/google');
const profileRoutes = require('./api/auth/profile');

const transactionRoutes = require('./api/transactions');
const categoryRoutes = require('./api/categories');

const app = express();
app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes);
app.use('/api/auth', googleAuth);
app.use('/api/auth', profileRoutes);
app.use('/api/transactions', transactionRoutes);
app.use('/api/categories', categoryRoutes);

// --- DB Viewer & Dump API (Temporary) ---
app.use('/db-view', express.static(path.join(__dirname, 'db_viewer')));

app.get('/api/all-data', async (req, res) => {
  try {
    const users = await pool.query('SELECT * FROM users ORDER BY id');
    const categories = await pool.query('SELECT * FROM categories ORDER BY id');
    const transactions = await pool.query('SELECT * FROM transactions ORDER BY id DESC');
    
    res.json({
      users: users.rows,
      categories: categories.rows,
      transactions: transactions.rows
    });
  } catch (err) {
    console.error('DB Dump Error:', err);
    res.status(500).json({ error: err.message });
  }
});
// ----------------------------------------

// Global Error Handler
app.use((err, req, res, next) => {
  console.error('Unhandled Error:', err);
  res.status(500).json({ error: 'Sunucu hatası', details: err.message });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
	console.log(`Server running on port ${PORT}`);
});
