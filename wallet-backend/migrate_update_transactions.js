const pool = require('./db');

async function migrate() {
  try {
    console.log('Migrating transactions table...');

    await pool.query(`
      ALTER TABLE transactions 
      ADD COLUMN IF NOT EXISTS category_id INTEGER;
    `);
    await pool.query(`
      ALTER TABLE transactions 
      ADD CONSTRAINT fk_category 
      FOREIGN KEY (category_id) 
      REFERENCES categories(id) 
      ON DELETE SET NULL;
    `);

    console.log('Migration completed: Updated transactions table (added category_id).');
  } catch (err) {
    console.error('Migration failed:', err);
  } finally {
    await pool.end();
  }
}

migrate();
