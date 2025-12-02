const pool = require('./db');

async function migrate() {
  try {
    // Rename title to name and add icon column
    await pool.query(`
      ALTER TABLE categories 
      RENAME COLUMN title TO name;
    `);
    await pool.query(`
      ALTER TABLE categories 
      ADD COLUMN IF NOT EXISTS icon VARCHAR(100);
    `);
    console.log('Migration completed: Updated categories table (title->name, added icon).');
  } catch (err) {
    if (err.message.includes('does not exist')) {
      console.log('Column already renamed or does not exist, continuing...');
    } else {
      console.error('Migration failed:', err);
    }
  } finally {
    await pool.end();
  }
}

migrate();
