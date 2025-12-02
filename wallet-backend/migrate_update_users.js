const pool = require('./db');

async function migrate() {
  try {
    // Add new columns if they don't exist
    await pool.query(`
      ALTER TABLE users 
      ADD COLUMN IF NOT EXISTS profile_picture TEXT,
      ADD COLUMN IF NOT EXISTS first_name VARCHAR(100),
      ADD COLUMN IF NOT EXISTS last_name VARCHAR(100);
    `);
    console.log('Migration completed: Added profile fields to users table.');
  } catch (err) {
    console.error('Migration failed:', err);
  } finally {
    await pool.end();
  }
}

migrate();
