CREATE DATABASE IF NOT EXISTS ServletCRUDMVC
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE ServletCRUDMVC;

CREATE TABLE IF NOT EXISTS category (
    cate_id INT AUTO_INCREMENT PRIMARY KEY,
    cate_name VARCHAR(255) NOT NULL,
    icons VARCHAR(255) NULL
);

-- Dữ liệu mẫu (có thể bỏ nếu không cần)
INSERT INTO category (cate_name, icons) VALUES
('Điện thoại', NULL),
('Laptop', NULL),
('Phụ kiện', NULL);
