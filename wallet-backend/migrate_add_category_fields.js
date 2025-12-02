const pool = require('./db');

async function migrate() {
  try {
    console.log('Migrating categories table...');

    // Add is_system column
    await pool.query(`
      ALTER TABLE categories 
      ADD COLUMN IF NOT EXISTS is_system BOOLEAN DEFAULT FALSE;
    `);

    // Add created_at column
    await pool.query(`
      ALTER TABLE categories 
      ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    `);

    // Add updated_at column
    await pool.query(`
      ALTER TABLE categories 
      ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    `);

    // Make user_id nullable because system categories might not have a specific user
    // OR we keep it NOT NULL and assign system categories to a specific admin user.
    // For now, let's make it nullable to allow system categories without a user.
    await pool.query(`
      ALTER TABLE categories 
      ALTER COLUMN user_id DROP NOT NULL;
    `);

    console.log('Migration completed: Added is_system, created_at, updated_at to categories.');
  } catch (err) {
    console.error('Migration failed:', err);
  } finally {
    await pool.end();
  }
}

migrate();
