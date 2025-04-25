CREATE DATABASE IF NOT EXISTS utilisateurs_db;
USE utilisateurs_db;

CREATE TABLE IF NOT EXISTS utilisateurs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);

INSERT INTO utilisateurs (name, email) VALUES
('Maxime', 'maxime@example.com'),
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');
