// Migration script: create tables if not exist
const fs = require('fs');
const path = require('path');
const pool = require('./db');

async function migrate() {
  const sql = fs.readFileSync(path.join(__dirname, 'db.sql'), 'utf8');
  try {
    await pool.query(sql);
    console.log('Migration completed: Tables created or already exist.');
  } catch (err) {
    console.error('Migration failed:', err);
  } finally {
    await pool.end();
  }
}

migrate();
