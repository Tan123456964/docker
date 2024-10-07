-- Create the users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert initial data into users table
INSERT INTO users (name, email) VALUES
('Alice', 'alice@example.com'),
('john', 'john@example.com'),
('Bob', 'bob@example.com');

-- Insert initial data into products table
INSERT INTO products (name, price) VALUES
('iphone', 999.99),
('Smartphone', 499.99);
