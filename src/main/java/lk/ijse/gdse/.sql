CREATE DATABASE IF NOT EXISTS complaint_db;

USE complaint_db;

CREATE TABLE users (
                       user_id INT AUTO_INCREMENT PRIMARY KEY,
                       full_name VARCHAR(100),
                       username VARCHAR(50) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       role ENUM('EMPLOYEE', 'ADMIN') NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE complaints (
                            complaint_id INT AUTO_INCREMENT PRIMARY KEY,
                            user_id INT NOT NULL,
                            title VARCHAR(100) NOT NULL,
                            description TEXT NOT NULL,
                            status ENUM('PENDING', 'IN_PROGRESS', 'RESOLVED') DEFAULT 'PENDING',
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            remark VARCHAR(255) DEFAULT 'No remarks',
                            FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);