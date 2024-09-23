CREATE DATABASE IF NOT EXISTS eCommerce;

USE eCommerce;

DROP TABLE IF EXISTS customer,
		     product,
		     orders,
                     categories,
                     order_items,
                     payments;
                     
CREATE TABLE customers(
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(50),
    phone_num VARCHAR(15) NOT NULL,
    city VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(30) NOT NULL,
    price DECIMAL(10,2),
    stock_quantity INT NOT NULL DEFAULT 0,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories (category_id),
    INDEX(category_id)
);

CREATE TABLE categories(
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    INDEX(category_name)
);

CREATE TABLE orders(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT ON DELETE SET NULL,
    total_amount DECIMAL(10,2),
    order_date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('pending', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending'
);

CREATE TABLE order_items(
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL (10, 2) NOT NULL,
    FOREIGN KEY(order_id) REFERENCES orders(order_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE
);



CREATE TABLE payments(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL (10,2) NOT NULL,
    payment_method ENUM ('card', 'upi', 'cash on delivery'),
    payment_status ENUM ('pending', 'successfull', 'failed'),
    transaction_date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

