CREATE DATABASE IF NOT EXISTS formation;

USE formation;

CREATE TABLE utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

-- Insertion des utilisateurs
INSERT INTO utilisateurs (nom, email) VALUES 
('Maxime Volpe', 'maxime.volpe@ynov.com'),
('Jean Dupont', 'jean.dupont@ynov.com'),
('Sophie Martin', 'sophie.martin@ynov.com');
