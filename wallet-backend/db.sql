-- users tablosu
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    profile_picture TEXT,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- transactions tablosu
CREATE TABLE IF NOT EXISTS transactions (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    type VARCHAR(10) NOT NULL CHECK (type IN ('income', 'expense')),
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    category VARCHAR(100),
    description TEXT,
    user_id INTEGER NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);


-- categories tablosu
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(10) NOT NULL CHECK (type IN ('income', 'expense')),
    icon VARCHAR(100),
    user_id INTEGER NOT NULL,
    CONSTRAINT fk_user_category FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);
