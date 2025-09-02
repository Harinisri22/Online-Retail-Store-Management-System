-- Online Retail Store Management System (MySQL)

-- 1) Drop & Create Database
DROP DATABASE IF EXISTS Online_Retail;
CREATE DATABASE Online_Retail CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE Online_Retail;

-- 2) Tables

-- Customers
CREATE TABLE Customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE,
  phone VARCHAR(20),
  address TEXT,
  join_date DATE DEFAULT (CURRENT_DATE())
) ENGINE=InnoDB;

-- Categories
CREATE TABLE Categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  description TEXT
) ENGINE=InnoDB;

-- Suppliers
CREATE TABLE Suppliers (
  supplier_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  contact_person VARCHAR(150),
  phone VARCHAR(20),
  email VARCHAR(150),
  address TEXT
) ENGINE=InnoDB;

-- Products
CREATE TABLE Products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  category_id INT NOT NULL,
  supplier_id INT,
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  stock_quantity INT NOT NULL DEFAULT 0,
  is_active TINYINT DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_products_category 
      FOREIGN KEY (category_id) REFERENCES Categories(category_id) 
      ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_products_supplier 
      FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) 
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Employees
CREATE TABLE Employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  role VARCHAR(100),
  phone VARCHAR(20),
  email VARCHAR(150)
) ENGINE=InnoDB;

-- Orders
CREATE TABLE Orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(50) DEFAULT 'Pending',
  total_amount DECIMAL(12,2) DEFAULT 0.00,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Order_Items
CREATE TABLE Order_Items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  price DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_items_order FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Payments
CREATE TABLE Payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  amount DECIMAL(12,2) NOT NULL,
  method VARCHAR(50) DEFAULT 'Card',
  status VARCHAR(50) DEFAULT 'Completed',
  CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Shipping
CREATE TABLE Shipping (
  shipping_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  shipping_date DATETIME,
  delivery_date DATETIME,
  status VARCHAR(50) DEFAULT 'Preparing',
  tracking_number VARCHAR(100),
  handled_by INT,
  CONSTRAINT fk_shipping_order FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_shipping_employee FOREIGN KEY (handled_by) REFERENCES Employees(employee_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Inventory_Log
CREATE TABLE Inventory_Log (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  change_type ENUM('IN','OUT','ADJUST') NOT NULL,
  quantity INT NOT NULL,
  change_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  note VARCHAR(255),
  CONSTRAINT fk_log_product FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 3) Indexes for performance (examples)
CREATE INDEX idx_products_name ON Products(name);
CREATE INDEX idx_orders_date ON Orders(order_date);
CREATE INDEX idx_payments_date ON Payments(payment_date);

-- 4) Sample Data Inserts

-- Categories
INSERT INTO Categories (category_name, description) VALUES
('Electronics','Phones, accessories, and gadgets'),
('Apparel','Clothing and fashion'),
('Home & Kitchen','Home appliances and kitchenware'),
('Sports','Fitness and sports equipment'),
('Books','Educational and leisure reading'),
('Toys','Kids and collectibles'),
('Beauty','Cosmetics and skincare'),
('Furniture','Home and office furniture'),
('Groceries','Daily essentials and food items'),
('Automotive','Car accessories and tools');

-- Suppliers
INSERT INTO Suppliers (name, contact_person, phone, email, address) VALUES
('Acme Electronics','Ravi Kumar','9876501234','ravi@acme.com','Chennai, India'),
('FashionHub','Priya Sharma','9876512345','priya@fashionhub.com','Bengaluru, India'),
('KitchenKing','Amit Verma','9876523456','amit@kitchenking.com','Delhi, India'),
('Sportify','Neha Kapoor','9876534567','neha@sportify.com','Mumbai, India'),
('EduBooks','Suresh Nair','9876545678','suresh@edubooks.com','Hyderabad, India'),
('ToyWorld','Kavita R','9876556789','kavita@toyworld.com','Chennai, India'),
('GlowBeauty','Anjali D','9876567890','anjali@glowbeauty.com','Pune, India'),
('FurniCraft','Rajesh T','9876578901','rajesh@furnicraft.com','Delhi, India'),
('FreshMart','Deepa I','9876589012','deepa@freshmart.com','Bengaluru, India'),
('AutoPlus','Manoj L','9876590123','manoj@autoplus.com','Mumbai, India');

-- Products
INSERT INTO Products (name, category_id, supplier_id, price, stock_quantity) VALUES
('Smartphone Model X', 1, 1, 19999.00, 50),
('Wireless Earbuds', 1, 1, 2499.00, 120),
('Laptop Pro 14', 1, 1, 75999.00, 30),
('Smartwatch S', 1, 1, 6999.00, 60),
('Men T-Shirt - Blue', 2, 2, 499.00, 200),
('Women Dress - Red', 2, 2, 1299.00, 150),
('Jeans - Black', 2, 2, 999.00, 180),
('Running Shoes', 4, 4, 2999.00, 100),
('Football', 4, 4, 799.00, 70),
('Yoga Mat', 4, 4, 599.00, 90),
('Non-stick Pan 26cm', 3, 3, 899.00, 80),
('Mixer Grinder', 3, 3, 3499.00, 40),
('Refrigerator 250L', 3, 3, 19999.00, 25),
('Cricket Bat', 4, 4, 1599.00, 60),
('Teddy Bear', 6, 6, 599.00, 75),
('LEGO Set', 6, 6, 2499.00, 50),
('Lipstick Pack', 7, 7, 499.00, 90),
('Face Cream', 7, 7, 799.00, 85),
('Office Chair', 8, 8, 4999.00, 30),
('Wooden Table', 8, 8, 7999.00, 20),
('Milk 1L', 9, 9, 60.00, 300),
('Rice 5kg', 9, 9, 350.00, 200),
('Olive Oil 1L', 9, 9, 550.00, 150),
('Car Tyre', 10, 10, 4999.00, 40),
('Car Battery', 10, 10, 6999.00, 35),
('Data Science Handbook', 5, 5, 799.00, 90),
('Novel - Fiction', 5, 5, 499.00, 100),
('Cookbook', 5, 5, 999.00, 80),
('Hair Dryer', 7, 7, 1999.00, 70),
('Perfume Spray', 7, 7, 1499.00, 60);


-- Customers
INSERT INTO Customers (name, email, phone, address) VALUES
('Asha R','asha@example.com','9123456780','Chennai, TN'),
('Rohan M','rohan@example.com','9123456781','Bengaluru, KA'),
('Meera K','meera@example.com','9123456782','Hyderabad, TS'),
('Vikram P','vikram@example.com','9123456783','Delhi, DL'),
('Nisha J','nisha@example.com','9123456784','Mumbai, MH'),
('Arjun S','arjun@example.com','9123456785','Kolkata, WB'),
('Kavya D','kavya@example.com','9123456786','Chennai, TN'),
('Rahul T','rahul@example.com','9123456787','Pune, MH'),
('Divya V','divya@example.com','9123456788','Bengaluru, KA'),
('Sanjay K','sanjay@example.com','9123456789','Delhi, DL'),
('Neha G','neha@example.com','9123456790','Hyderabad, TS'),
('Suresh B','suresh@example.com','9123456791','Mumbai, MH'),
('Lakshmi P','lakshmi@example.com','9123456792','Chennai, TN'),
('Manish C','manish@example.com','9123456793','Kolkata, WB'),
('Pooja L','pooja@example.com','9123456794','Pune, MH'),
('Anil R','anil@example.com','9123456795','Delhi, DL'),
('Geeta H','geeta@example.com','9123456796','Hyderabad, TS'),
('Varun Y','varun@example.com','9123456797','Mumbai, MH'),
('Sneha Z','sneha@example.com','9123456798','Chennai, TN'),
('Hari O','hari@example.com','9123456799','Bengaluru, KA');


-- Employees 
INSERT INTO Employees (name, role, phone, email) VALUES
('Kumar S','Shipping Manager','9000000001','kumar@example.com'),
('Lekha P','Warehouse Staff','9000000002','lekha@example.com'),
('Arun V','Sales Executive','9000000003','arun@example.com'),
('Divya N','Customer Support','9000000004','divya@example.com'),
('Mahesh G','IT Support','9000000005','mahesh@example.com'),
('Priya H','Accountant','9000000006','priya@example.com'),
('Ravi P','Logistics','9000000007','ravi@example.com'),
('Snehal T','Store Manager','9000000008','snehal@example.com'),
('Ganesh M','Procurement','9000000009','ganesh@example.com'),
('Latha S','HR','9000000010','latha@example.com'),
('Kumar S','Shipping Manager','9000000001','kumar@example.com'),
('Lekha P','Warehouse Staff','9000000002','lekha@example.com'),
('Arun V','Sales Executive','9000000003','arun@example.com'),
('Divya N','Customer Support','9000000004','divya@example.com');

-- Orders 
INSERT INTO Orders (customer_id, status, total_amount) VALUES
(1, 'Processing', 20498.00),
(2, 'Shipped', 499.00),
(3, 'Delivered', 2999.00),
(4, 'Pending', 75999.00),
(5, 'Processing', 899.00),
(6, 'Delivered', 1299.00),
(7, 'Shipped', 1999.00),
(8, 'Processing', 3499.00),
(9, 'Delivered', 4999.00),
(10, 'Pending', 6999.00),
(11, 'Processing', 999.00),
(12, 'Shipped', 799.00),
(13, 'Delivered', 599.00),
(14, 'Processing', 350.00),
(15, 'Shipped', 550.00),
(16, 'Delivered', 1599.00),
(17, 'Processing', 2499.00),
(18, 'Shipped', 2999.00),
(19, 'Delivered', 4999.00),
(20, 'Processing', 6999.00);

-- Order_Items
INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 19999.00),
(1, 2, 1, 499.00),
(2, 5, 1, 499.00),
(3, 8, 1, 2999.00),
(4, 3, 1, 75999.00),
(5, 11, 1, 899.00),
(6, 6, 1, 1299.00),
(7, 29, 1, 1999.00),
(8, 12, 1, 3499.00),
(9, 19, 1, 4999.00),
(10, 4, 1, 6999.00),
(11, 7, 1, 999.00),
(12, 26, 1, 799.00),
(13, 15, 1, 599.00),
(14, 22, 1, 350.00),
(15, 23, 1, 550.00),
(16, 14, 1, 1599.00),
(17, 16, 1, 2499.00),
(18, 18, 1, 2999.00),
(19, 20, 1, 4999.00),
(20, 10, 1, 6999.00),
(6, 17, 1, 499.00),
(7, 18, 1, 799.00),
(8, 24, 1, 4999.00),
(9, 25, 1, 6999.00),
(10, 13, 1, 19999.00),
(11, 21, 5, 300.00),
(12, 27, 1, 499.00),
(13, 28, 1, 999.00),
(14, 30, 1, 1499.00);

-- Payments
INSERT INTO Payments (order_id, amount, method, status) VALUES
(1, 20498.00, 'Card', 'Completed'),
(2, 499.00, 'UPI', 'Completed'),
(3, 2999.00, 'COD', 'Completed'),
(4, 75999.00, 'Card', 'Pending'),
(5, 899.00, 'UPI', 'Completed'),
(6, 1299.00, 'Card', 'Completed'),
(7, 1999.00, 'UPI', 'Completed'),
(8, 3499.00, 'Card', 'Completed'),
(9, 4999.00, 'NetBanking', 'Completed'),
(10, 6999.00, 'COD', 'Completed'),
(11, 999.00, 'UPI', 'Completed'),
(12, 799.00, 'Card', 'Completed'),
(13, 599.00, 'UPI', 'Completed'),
(14, 350.00, 'NetBanking', 'Completed'),
(15, 550.00, 'UPI', 'Completed'),
(16, 1599.00, 'Card', 'Completed'),
(17, 2499.00, 'UPI', 'Completed'),
(18, 2999.00, 'Card', 'Completed'),
(19, 950.00, 'COD', 'Completed'),
(20, 3700.00, 'Card', 'Completed');

-- Shipping
INSERT INTO Shipping (shipping_id, order_id, shipping_date, delivery_date, status, tracking_number) VALUES
(1, 1, '2024-07-16', '2024-07-20', 'Delivered', 'TRK1001'),
(2, 2, '2024-07-18', '2024-07-23', 'Delivered', 'TRK1002'),
(3, 3, '2024-07-20', '2024-07-25', 'Shipped', 'TRK1003'),
(4, 4, '2024-07-22', '2024-07-27', 'Pending', 'TRK1004'),
(5, 5, '2024-07-24', '2024-07-30', 'Delivered', 'TRK1005'),
(6, 6, '2024-07-25', '2024-07-31', 'Delivered', 'TRK1006'),
(7, 7, '2024-07-26', '2024-08-01', 'Shipped', 'TRK1007'),
(8, 8, '2024-07-27', '2024-08-02', 'Pending', 'TRK1008'),
(9, 9, '2024-07-28', '2024-08-03', 'Delivered', 'TRK1009'),
(10, 10, '2024-07-29', '2024-08-04', 'Delivered', 'TRK1010'),
(11, 11, '2024-07-30', '2024-08-05', 'Shipped', 'TRK1011'),
(12, 12, '2024-07-31', '2024-08-06', 'Pending', 'TRK1012'),
(13, 13, '2024-08-01', '2024-08-07', 'Delivered', 'TRK1013'),
(14, 14, '2024-08-02', '2024-08-08', 'Delivered', 'TRK1014'),
(15, 15, '2024-08-03', '2024-08-09', 'Shipped', 'TRK1015'),
(16, 16, '2024-08-04', '2024-08-10', 'Pending', 'TRK1016'),
(17, 17, '2024-08-05', '2024-08-11', 'Delivered', 'TRK1017'),
(18, 18, '2024-08-06', '2024-08-12', 'Delivered', 'TRK1018'),
(19, 19, '2024-08-07', '2024-08-13', 'Shipped', 'TRK1019'),
(20, 20, '2024-08-08', '2024-08-14', 'Pending', 'TRK1020');


-- Inventory Logs 
INSERT INTO Inventory_Log (product_id, change_type, quantity, change_date, note)
VALUES
(1, 'IN', 100, '2024-09-01 10:15:00', 'Initial stock from supplier'),
(2, 'IN', 200, '2024-09-02 11:00:00', 'Bulk stock purchase'),
(3, 'IN', 150, '2024-09-03 09:30:00', 'Restock'),
(4, 'OUT', 20, '2024-09-03 15:45:00', 'Customer order shipment'),
(5, 'OUT', 10, '2024-09-04 12:20:00', 'Customer order shipment'),
(6, 'IN', 300, '2024-09-05 14:00:00', 'New shipment from supplier'),
(7, 'ADJUST', -5, '2024-09-06 16:10:00', 'Damaged items removed'),
(8, 'OUT', 50, '2024-09-07 13:40:00', 'Customer bulk order'),
(9, 'IN', 120, '2024-09-08 08:25:00', 'Stock replenishment'),
(10, 'OUT', 15, '2024-09-09 10:50:00', 'Customer order shipment'),
(11, 'IN', 90, '2024-09-10 11:45:00', 'New batch arrival'),
(12, 'OUT', 30, '2024-09-11 09:15:00', 'Customer order'),
(13, 'ADJUST', 3, '2024-09-11 17:30:00', 'Inventory correction'),
(14, 'IN', 200, '2024-09-12 14:55:00', 'Restock'),
(15, 'OUT', 40, '2024-09-13 10:10:00', 'Customer order'),
(16, 'IN', 180, '2024-09-14 15:05:00', 'New supplier shipment'),
(17, 'OUT', 25, '2024-09-15 11:30:00', 'Customer order'),
(18, 'OUT', 35, '2024-09-16 12:45:00', 'Customer order'),
(19, 'IN', 140, '2024-09-17 09:50:00', 'Replenishment'),
(20, 'ADJUST', -2, '2024-09-18 16:20:00', 'Damaged stock adjusted');

-- 5) Trigger: When an order_item is inserted, reduce stock and write to Inventory_Log
DELIMITER $$
CREATE TRIGGER trg_after_order_item_insert
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
  DECLARE current_stock INT;
  SELECT stock_quantity INTO current_stock FROM Products WHERE product_id = NEW.product_id FOR UPDATE;
  IF current_stock - NEW.quantity < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for product';
  ELSE
    UPDATE Products SET stock_quantity = stock_quantity - NEW.quantity WHERE product_id = NEW.product_id;
    INSERT INTO Inventory_Log (product_id, change_type, quantity, note) VALUES (NEW.product_id, 'OUT', NEW.quantity, CONCAT('Order #', NEW.order_id));
  END IF;
END$$
DELIMITER ;

-- 6) Stored procedure: Place an order (simple transactional flow)
DELIMITER $$
CREATE PROCEDURE place_order(
  IN p_customer_id INT,
  IN p_total_amount DECIMAL(12,2),
  IN p_items TEXT -- changed from JSON
)
BEGIN
  DECLARE v_order_id INT;

  START TRANSACTION;
  INSERT INTO Orders (customer_id, status, total_amount)
  VALUES (p_customer_id, 'Processing', p_total_amount);
  
  SET v_order_id = LAST_INSERT_ID();

  -- You can handle parsing in the application since TEXT can't use JSON_EXTRACT

  COMMIT;
  SELECT v_order_id AS order_id;
END$$
DELIMITER ;

-- b) Total sales per product
SELECT p.product_id, p.name, SUM(oi.quantity) AS total_sold, SUM(oi.quantity * oi.price) AS revenue
FROM Order_Items oi
JOIN Products p ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY revenue DESC;

-- c) Revenue per month (last 12 months)
SELECT 
  DATE_FORMAT(o.order_date, '%Y-%m') AS `year_month`,
  SUM(o.total_amount) AS `revenue`
FROM Orders o
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY DATE_FORMAT(o.order_date, '%Y-%m') DESC;

-- d) Top 5 customers by total spend
SELECT c.customer_id, c.name, SUM(p.amount) AS total_spent
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 5;

-- e) Products low on stock (threshold example)
SELECT product_id, name, stock_quantity FROM Products WHERE stock_quantity <= 10 ORDER BY stock_quantity ASC;

-- f) Find orders without payment
SELECT o.order_id, o.customer_id, o.total_amount
FROM Orders o
LEFT JOIN Payments p ON p.order_id = o.order_id
WHERE p.payment_id IS NULL;

-- g) Employees handling most shipments
SELECT e.employee_id, e.name, COUNT(s.shipping_id) AS shipments_handled
FROM Shipping s
JOIN Employees e ON s.handled_by = e.employee_id
GROUP BY e.employee_id, e.name
ORDER BY shipments_handled DESC;

-- 8) Example CRUD operations
-- Create: Add product
INSERT INTO Products (name, category_id, supplier_id, price, stock_quantity) VALUES ('Table Lamp',3, NULL, 699.00, 40);

-- Read: Get product details
SELECT * FROM Products WHERE product_id = 1;

-- Update: Change price
UPDATE Products SET price = 20999.00 WHERE product_id = 1;

-- Delete: Remove a product (soft delete recommended using is_active flag but here is hard delete)
DELETE FROM Products WHERE product_id = 999;

-- 9) Cleanup (if needed)
-- DROP TRIGGER IF EXISTS trg_after_order_item_insert;
-- DROP PROCEDURE IF EXISTS place_order;
-- DROP DATABASE Online_Retail;

