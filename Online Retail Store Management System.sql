-- Online Retail Store Management System 

DROP DATABASE IF EXISTS Online_Retail_Store;
CREATE DATABASE Online_Retail_Store CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE Online_Retail_Store;

-- Customers
CREATE TABLE Customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE,
  phone VARCHAR(20),
  city VARCHAR(100),
  address TEXT,
  join_date DATE DEFAULT (CURRENT_DATE)
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
  city VARCHAR(100),
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
  CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_products_supplier FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Employees
CREATE TABLE Employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  role VARCHAR(100),
  phone VARCHAR(20),
  email VARCHAR(150),
  city VARCHAR(100)
) ENGINE=InnoDB;

-- Stores 
CREATE TABLE Stores (
  store_id INT AUTO_INCREMENT PRIMARY KEY,
  store_name VARCHAR(150),
  city VARCHAR(100),
  address TEXT,
  manager_id INT,
  CONSTRAINT fk_store_manager FOREIGN KEY (manager_id) REFERENCES Employees(employee_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Orders
CREATE TABLE Orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(50) DEFAULT 'Pending',
  store_id INT,
  total_amount DECIMAL(12,2) DEFAULT 0.00,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_orders_store FOREIGN KEY (store_id) REFERENCES Stores(store_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Order_Items (order details)
CREATE TABLE Order_Items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  unit_price DECIMAL(10,2) NOT NULL,
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

-- Deliveries (shipment tracking)
CREATE TABLE Deliveries (
  delivery_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  shipped_date DATE,
  expected_delivery_date DATE,
  delivered_date DATE,
  status VARCHAR(50) DEFAULT 'Preparing',
  handled_by INT,
  tracking_number VARCHAR(100),
  CONSTRAINT fk_delivery_order FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_delivery_employee FOREIGN KEY (handled_by) REFERENCES Employees(employee_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Inventory table
CREATE TABLE Inventory (
  inventory_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  store_id INT NOT NULL,
  quantity INT NOT NULL,
  CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_inventory_store FOREIGN KEY (store_id) REFERENCES Stores(store_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Index 
CREATE INDEX idx_products_name ON Products(name);
CREATE INDEX idx_orders_date ON Orders(order_date);
CREATE INDEX idx_payments_date ON Payments(payment_date);


-- Categories 
INSERT INTO Categories (category_name, description) VALUES
('Electronics','Phones, laptops, accessories'),
('Apparel','Men and Women clothing'),
('Home & Kitchen','Appliances and cookware'),
('Beauty','Cosmetics and skincare'),
('Books','Educational and fiction'),
('Toys','Kids toys and games'),
('Sports','Sports equipment'),
('Grocery','Daily essentials'),
('Furniture','Home furniture'),
('Automotive','Car accessories'),
('Stationery','Office and school supplies'),
('Footwear','Shoes and sandals'),
('Jewellery','Fashion jewellery'),
('Health','Healthcare products'),
('Garden','Garden tools & plants'),
('Pet Care','Pet food and accessories'),
('Baby Care','Baby products'),
('Office Supplies','Office furniture and equipment'),
('Mobile Accessories','Chargers, cables, covers'),
('Kitchen Storage','Containers & organizers');

-- Suppliers  - Indian names & cities
INSERT INTO Suppliers (name, contact_person, phone, email, city, address) VALUES
('Reliance Retail','Amit Shah','9876500001','amit.shah@rilretail.in','Mumbai','Dhirubhai Ambani Complex, Mumbai'),
('Tata Enterprises','Priya Nair','9876500002','priya.nair@tataconsult.in','Mumbai','Tata Centre, Mumbai'),
('Flipkart Wholesale','Rohit Verma','9876500003','rohit.verma@flip.in','Bengaluru','Manyata Tech Park, Bengaluru'),
('Mahindra Supply','Sanjay Rao','9876500004','sanjay.rao@mahindra.in','Pune','Mahindra Towers, Pune'),
('D-Mart Foods','Sunita Patel','9876500005','sunita.patel@dmart.in','Mumbai','Mira Road, Mumbai'),
('BigBasket','Kavya Menon','9876500006','kavya.menon@bigbasket.in','Bengaluru','Whitefield, Bengaluru'),
('Godrej & Sons','Ramesh Iyer','9876500007','ramesh.iyer@godrej.com','Mumbai','Pirojshanagar, Vikhroli'),
('Amul Distributors','Neha Desai','9876500008','neha.desai@amul.coop','Gandhinagar','Amul Dairy, Gandhinagar'),
('Bajaj Suppliers','Vikram Singh','9876500009','vikram.singh@bajaj.com','Pune','Bajaj Auto Plant, Pune'),
('Asian Paints Pvt','Anita Rao','9876500010','anita.rao@asianpaints.in','Mumbai','Goalghar, Mumbai'),
('Hindustan Unilever','Suresh Kumar','9876500011','suresh.kumar@hul.co.in','Mumbai','Andheri, Mumbai'),
('ITC Ltd','Meera Gupta','9876500012','meera.gupta@itc.in','Kolkata','ITC House, Kolkata'),
('Zomato Supplies','Arun Prakash','9876500013','arun.prakash@zomato.in','Gurgaon','Gurgaon Office, Haryana'),
('Spencers Retail','Ritu Sharma','9876500014','ritu.sharma@spencer.in','Kolkata','Park Street, Kolkata'),
('Paytm Mall','Karan Malik','9876500015','karan.malik@paytm.in','Noida','Noida Sector Office'),
('Myntra Sourcing','Ankita Singh','9876500016','ankita.singh@myntra.in','Gurgaon','Gurgaon Sourcing Unit'),
('Tanishq Supplies','Rohini Joshi','9876500017','rohini.joshi@tanishq.in','Bengaluru','Jewellery Park, Bengaluru'),
('Croma Sourcing','Manish Bhat','9876500018','manish.bhat@croma.in','Mumbai','Lower Parel, Mumbai'),
('SpiceJet Logistics','Ajay Mehra','9876500019','ajay.mehra@spicejet.in','Gurgaon','IGI Airport Cargo'),
('Delhivery Partners','Pooja Yadav','9876500020','pooja.yadav@delhivery.in','New Delhi','NCR Logistics Hub');

-- Products 
INSERT INTO Products (name, category_id, supplier_id, price, stock_quantity) VALUES
('Smartphone X Pro', 1, 1, 39999.00, 120),
('Laptop Ultra 14', 1, 3, 75999.00, 45),
('Wireless Earbuds', 1, 6, 2999.00, 300),
('Men Cotton Shirt', 2, 2, 699.00, 250),
('Women Anarkali Dress', 2, 16, 2499.00, 150),
('Non-stick Kadai', 3, 5, 1199.00, 200),
('Mixer Grinder 750W', 3, 4, 3499.00, 80),
('Vitamin C Tablets', 14, 11, 499.00, 500),
('Kids Puzzle Set', 6, 13, 799.00, 180),
('Running Shoes', 7, 9, 2999.00, 140),
('Rice 5kg', 8, 8, 399.00, 600),
('Dining Table 4-seater', 9, 7, 15999.00, 20),
('Car Air Freshener', 10, 19, 199.00, 400),
('Office Notebook Pack', 11, 12, 249.00, 450),
('Leather Formal Shoes', 12, 2, 3999.00, 90),
('Gold Plated Necklace', 13, 17, 7999.00, 40),
('Pet Dog Food 5kg', 16, 6, 1299.00, 200),
('Baby Diapers Pack', 17, 11, 699.00, 350),
('Mobile Charger Fast', 19, 18, 599.00, 500),
('Kitchen Storage Set', 20, 5, 1499.00, 220);

-- Employees 
INSERT INTO Employees (name, role, phone, email, city) VALUES
('Rahul Mehta','Store Manager','9900000001','rahul.mehta@retail.in','Mumbai'),
('Suman Reddy','Sales Executive','9900000002','suman.reddy@retail.in','Hyderabad'),
('Pooja Singh','Cashier','9900000003','pooja.singh@retail.in','New Delhi'),
('Amit Rao','Warehouse Supervisor','9900000004','amit.rao@retail.in','Pune'),
('Sunita Iyer','Customer Support','9900000005','sunita.iyer@retail.in','Chennai'),
('Manoj Kumar','Delivery Executive','9900000006','manoj.kumar@retail.in','Gurgaon'),
('Neha Patel','Inventory Manager','9900000007','neha.patel@retail.in','Ahmedabad'),
('Arjun Nair','Procurement','9900000008','arjun.nair@retail.in','Bengaluru'),
('Kavita Sharma','HR','9900000009','kavita.sharma@retail.in','Lucknow'),
('Vikas Gupta','Accounts','9900000010','vikas.gupta@retail.in','Noida'),
('Rashmi Desai','Marketing','9900000011','rashmi.desai@retail.in','Mumbai'),
('Sachin Yadav','IT Support','9900000012','sachin.yadav@retail.in','Pune'),
('Rekha Menon','Store Supervisor','9900000013','rekha.menon@retail.in','Kochi'),
('Deepak Joshi','Warehouse Staff','9900000014','deepak.joshi@retail.in','Indore'),
('Gauri Patel','Sales Associate','9900000015','gauri.patel@retail.in','Surat'),
('Rohan Bose','Driver','9900000016','rohan.bose@retail.in','Kolkata'),
('Nisha Verma','Quality Check','9900000017','nisha.verma@retail.in','Jaipur'),
('Pradeep Kumar','Logistics','9900000018','pradeep.kumar@retail.in','Bhopal'),
('Megha Sharma','Assistant Manager','9900000019','megha.sharma@retail.in','Dehradun'),
('Lokesh Singh','Store Executive','9900000020','lokesh.singh@retail.in','Kanpur');

-- Customers 
INSERT INTO Customers (name, email, phone, city, address) VALUES
('Rajesh Kumar','rajesh.kumar@email.com','9111111111','Mumbai','Bandra West, Mumbai'),
('Priya Sharma','priya.sharma@email.com','9111111112','Delhi','Connaught Place, Delhi'),
('Amit Patel','amit.patel@email.com','9111111113','Ahmedabad','Navrangpura, Ahmedabad'),
('Sneha Reddy','sneha.reddy@email.com','9111111114','Hyderabad','Banjara Hills, Hyderabad'),
('Ravi Verma','ravi.verma@email.com','9111111115','Bangalore','Koramangala, Bangalore'),
('Anjali Singh','anjali.singh@email.com','9111111116','Pune','Kothrud, Pune'),
('Vikram Joshi','vikram.joshi@email.com','9111111117','Chennai','T Nagar, Chennai'),
('Neha Gupta','neha.gupta@email.com','9111111118','Kolkata','Salt Lake, Kolkata'),
('Sanjay Mishra','sanjay.mishra@email.com','9111111119','Lucknow','Gomti Nagar, Lucknow'),
('Pooja Nair','pooja.nair@email.com','9111111120','Kochi','Marine Drive, Kochi'),
('Alok Tiwari','alok.tiwari@email.com','9111111121','Indore','Vijay Nagar, Indore'),
('Kavita Desai','kavita.desai@email.com','9111111122','Surat','Athwa Lines, Surat'),
('Rahul Bose','rahul.bose@email.com','9111111123','Kolkata','Park Street, Kolkata'),
('Sunil Mehta','sunil.mehta@email.com','9111111124','Jaipur','MI Road, Jaipur'),
('Anita Choudhary','anita.choudhary@email.com','9111111125','Bhopal','Arera Colony, Bhopal'),
('Mohan Sharma','mohan.sharma@email.com','9111111126','Dehradun','Rajpur Road, Dehradun'),
('Sarita Pandey','sarita.pandey@email.com','9111111127','Kanpur','Civil Lines, Kanpur'),
('Deepak Agarwal','deepak.agarwal@email.com','9111111128','Noida','Sector 62, Noida'),
('Lata Reddy','lata.reddy@email.com','9111111129','Gurgaon','Sector 14, Gurgaon'),
('Vishal Kumar','vishal.kumar@email.com','9111111130','Mumbai','Andheri East, Mumbai');

-- Stores 
INSERT INTO Stores (store_name, city, address, manager_id) VALUES
('Mumbai Central Store','Mumbai','Tardeo Market Road, Mumbai',1),
('Hyderabad Banjara Store','Hyderabad','Banjara Hills, Hyderabad',2),
('Delhi Connaught Store','New Delhi','Connaught Place, New Delhi',3),
('Pune Magarpatta Store','Pune','Magarpatta City, Pune',4),
('Chennai Egmore Store','Chennai','Egmore, Chennai',5),
('Gurgaon Sector 14 Store','Gurgaon','Sector 14, Gurgaon',6),
('Ahmedabad CG Road Store','Ahmedabad','CG Road, Ahmedabad',7),
('Bengaluru Koramangala Store','Bengaluru','Koramangala, Bengaluru',8),
('Lucknow Hazratganj Store','Lucknow','Hazratganj, Lucknow',9),
('Noida Sector 18 Store','Noida','Sector 18, Noida',10),
('Mumbai Andheri Store','Mumbai','Andheri West, Mumbai',11),
('Pune Wakad Store','Pune','Wakad, Pune',12),
('Kochi Marine Drive Store','Kochi','Marine Drive, Kochi',13),
('Indore MG Road Store','Indore','MG Road, Indore',14),
('Surat Udhna Store','Surat','Udhna Darwaza, Surat',15),
('Kolkata Park Street Store','Kolkata','Park Street, Kolkata',16),
('Jaipur MI Road Store','Jaipur','MI Road, Jaipur',17),
('Bhopal DB Mall Store','Bhopal','DB Mall, Bhopal',18),
('Dehradun Paltan Store','Dehradun','Paltan Bazaar, Dehradun',19),
('Kanpur Civil Lines Store','Kanpur','Civil Lines, Kanpur',20);

-- Inventory 
INSERT INTO Inventory (product_id, store_id, quantity) VALUES
(1,1,50),(1,11,30),(2,8,20),(2,2,15),(3,6,200),
(4,4,120),(5,5,80),(6,3,150),(7,4,60),(8,10,500),
(9,13,90),(10,9,70),(11,1,600),(12,8,5),(13,15,40),
(14,12,300),(15,2,45),(16,17,25),(17,14,120),(18,16,75);

-- Orders 
INSERT INTO Orders (customer_id, order_date, status, store_id, total_amount) VALUES
(1,'2025-01-15 10:05:00','Delivered',1,39999.00),
(2,'2025-01-16 11:15:00','Delivered',2,699.00),
(3,'2025-01-17 09:20:00','Shipped',3,8997.00),
(4,'2025-01-18 12:00:00','Pending',4,15999.00),
(5,'2025-01-19 14:30:00','Delivered',5,1199.00),
(6,'2025-01-20 16:45:00','Cancelled',6,0.00),
(7,'2025-01-21 10:30:00','Delivered',7,3499.00),
(8,'2025-01-22 13:55:00','Shipped',8,399.00),
(9,'2025-01-23 15:10:00','Pending',9,799.00),
(10,'2025-01-24 09:40:00','Delivered',10,2999.00),
(11,'2025-01-25 11:25:00','Delivered',11,15999.00),
(12,'2025-01-26 17:50:00','Shipped',12,249.00),
(13,'2025-01-27 08:05:00','Pending',13,1299.00),
(14,'2025-01-28 19:00:00','Delivered',14,699.00),
(15,'2025-01-29 20:10:00','Delivered',15,599.00),
(16,'2025-01-30 07:30:00','Shipped',16,499.00),
(17,'2025-01-31 18:20:00','Pending',17,1499.00),
(18,'2025-02-01 21:35:00','Delivered',18,249.00),
(19,'2025-02-02 06:55:00','Shipped',19,75999.00),
(20,'2025-02-03 08:15:00','Pending',20,1499.00);

-- Order_Items 
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(1,1,1,39999.00),
(2,4,1,699.00),
(3,10,1,2999.00),
(3,3,2,2999.00),
(4,12,1,15999.00),
(5,6,1,1199.00),
(7,7,1,3499.00),
(8,11,1,399.00),
(9,9,1,799.00),
(10,10,1,2999.00),
(11,12,1,15999.00),
(12,14,1,249.00),
(13,17,1,1299.00),
(14,18,1,699.00),
(15,19,1,599.00),
(16,8,1,499.00),
(17,20,1,1499.00),
(18,14,1,249.00),
(19,2,1,75999.00),
(20,20,1,1499.00);

-- Payments
INSERT INTO Payments (order_id, payment_date, amount, method, status) VALUES
(1,'2025-01-15 10:10:00',39999.00,'Card','Completed'),
(2,'2025-01-16 11:20:00',699.00,'UPI','Completed'),
(3,'2025-01-17 09:30:00',8997.00,'Card','Completed'),
(5,'2025-01-19 14:35:00',1199.00,'COD','Completed'),
(7,'2025-01-21 10:35:00',3499.00,'UPI','Completed'),
(8,'2025-01-22 13:58:00',399.00,'Card','Completed'),
(9,'2025-01-23 15:15:00',799.00,'NetBanking','Completed'),
(10,'2025-01-24 09:50:00',2999.00,'Card','Completed'),
(11,'2025-01-25 11:40:00',15999.00,'Card','Completed'),
(12,'2025-01-26 18:00:00',249.00,'UPI','Completed'),
(13,'2025-01-27 08:10:00',1299.00,'COD','Completed'),
(14,'2025-01-28 19:10:00',699.00,'NetBanking','Completed'),
(15,'2025-01-29 20:20:00',599.00,'Card','Completed'),
(16,'2025-01-30 07:40:00',499.00,'UPI','Completed'),
(17,'2025-01-31 18:30:00',1499.00,'Card','Completed'),
(18,'2025-02-01 21:40:00',249.00,'COD','Completed'),
(19,'2025-02-02 07:05:00',75999.00,'UPI','Completed'),
(20,'2025-02-03 08:20:00',1499.00,'Card','Pending');

-- Deliveries 
INSERT INTO Deliveries (order_id, shipped_date, expected_delivery_date, delivered_date, status, handled_by, tracking_number) VALUES
(1,'2025-01-15','2025-01-18','2025-01-17','Delivered',6,'TRK-IN-1001'),
(2,'2025-01-16','2025-01-19','2025-01-18','Delivered',6,'TRK-IN-1002'),
(3,'2025-01-17','2025-01-21',NULL,'Shipped',6,'TRK-IN-1003'),
(4,'2025-01-18','2025-01-23',NULL,'Preparing',6,'TRK-IN-1004'),
(5,'2025-01-19','2025-01-22','2025-01-21','Delivered',16,'TRK-IN-1005'),
(7,'2025-01-21','2025-01-24','2025-01-23','Delivered',16,'TRK-IN-1006'),
(8,'2025-01-22','2025-01-26',NULL,'Shipped',6,'TRK-IN-1007'),
(9,'2025-01-23','2025-01-27',NULL,'Preparing',6,'TRK-IN-1008'),
(10,'2025-01-24','2025-01-28','2025-01-27','Delivered',16,'TRK-IN-1009'),
(11,'2025-01-25','2025-01-29','2025-01-28','Delivered',6,'TRK-IN-1010'),
(12,'2025-01-26','2025-01-30',NULL,'Shipped',16,'TRK-IN-1011'),
(13,'2025-01-27','2025-02-01',NULL,'Preparing',6,'TRK-IN-1012'),
(14,'2025-01-28','2025-01-31','2025-01-30','Delivered',16,'TRK-IN-1013'),
(15,'2025-01-29','2025-02-02','2025-02-01','Delivered',6,'TRK-IN-1014'),
(16,'2025-01-30','2025-02-03',NULL,'Shipped',16,'TRK-IN-1015'),
(17,'2025-01-31','2025-02-05',NULL,'Preparing',6,'TRK-IN-1016'),
(18,'2025-02-01','2025-02-04','2025-02-03','Delivered',16,'TRK-IN-1017'),
(19,'2025-02-02','2025-02-06',NULL,'Shipped',6,'TRK-IN-1018'),
(20,'2025-02-03','2025-02-08',NULL,'Preparing',NULL,'TRK-IN-1019');

-- QUERIES : 

-- 1) Show all products with price and stock
SELECT product_id, name, price, stock_quantity FROM Products;

-- 2) List all customers with city
SELECT customer_id, name, email, city FROM Customers;

-- 3) Show suppliers from Mumbai
SELECT supplier_id, name, contact_person, city FROM Suppliers WHERE city = 'Mumbai';

-- 4) Total number of products per category
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name;

-- 5) Total stock quantity for each product across stores (sum from Inventory)
SELECT p.product_id, p.name, SUM(i.quantity) AS total_stock
FROM Products p
JOIN Inventory i ON p.product_id = i.product_id
GROUP BY p.product_id, p.name
ORDER BY total_stock DESC;

-- 6) Top 5 most expensive products
SELECT name, price FROM Products ORDER BY price DESC LIMIT 5;

-- 7) Orders placed on a specific date
SELECT order_id, customer_id, order_date, status, total_amount FROM Orders WHERE DATE(order_date) = '2025-01-24';

-- 8) Total sales (sum of order totals) by store
SELECT s.store_name, SUM(o.total_amount) AS store_sales
FROM Orders o
JOIN Stores s ON o.store_id = s.store_id
GROUP BY s.store_name
ORDER BY store_sales DESC;

-- 9) Customers who have not placed any order (left join)
SELECT c.customer_id, c.name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 10) Orders and their items (join Orders -> Order_Items -> Products)
SELECT o.order_id, o.order_date, p.name AS product_name, oi.quantity, oi.unit_price
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- 11) Total revenue by product (sum of quantity * unit_price from order_items)
SELECT p.product_id, p.name, SUM(oi.quantity * oi.unit_price) AS revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY revenue DESC;

-- 12) Payments pending (status not completed)
SELECT payment_id, order_id, amount, method, status FROM Payments WHERE status <> 'Completed';

-- 13) Count of orders by status
SELECT status, COUNT(*) AS total_orders FROM Orders GROUP BY status;

-- 14) Deliveries that are delayed (expected_delivery_date < CURRENT_DATE and not delivered)
SELECT delivery_id, order_id, expected_delivery_date, status
FROM Deliveries
WHERE expected_delivery_date < CURRENT_DATE AND (delivered_date IS NULL OR status <> 'Delivered');

-- 15) Inventory items less than threshold (e.g., less than 50)
SELECT i.inventory_id, p.name, s.store_name, i.quantity
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id
JOIN Stores s ON i.store_id = s.store_id
WHERE i.quantity < 50
ORDER BY i.quantity ASC;

-- 16) Employees handling most deliveries
SELECT e.employee_id, e.name, COUNT(d.delivery_id) AS deliveries_handled
FROM Deliveries d
JOIN Employees e ON d.handled_by = e.employee_id
GROUP BY e.employee_id, e.name
ORDER BY deliveries_handled DESC;

-- 17) List products supplied by a specific supplier (e.g., supplier_id = 1)
SELECT p.product_id, p.name, p.price FROM Products p WHERE p.supplier_id = 1;

-- 18) Monthly revenue (group by year and month) from Orders
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_amount) AS revenue
FROM Orders
WHERE order_date >= '2025-01-01'
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year DESC, month DESC;

-- 19) Find customers who spent the most (Top 5) using Payments join Orders
SELECT c.customer_id, c.name, SUM(pay.amount) AS total_spent
FROM Payments pay
JOIN Orders o ON pay.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 5;

-- 20) Total inventory value per store (sum quantity * product price)
SELECT s.store_id, s.store_name, SUM(i.quantity * p.price) AS inventory_value
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id
JOIN Stores s ON i.store_id = s.store_id
GROUP BY s.store_id, s.store_name
ORDER BY inventory_value DESC;

-- 21) Products never ordered
SELECT p.product_id, p.name
FROM Products p
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

-- 22) Average order value
SELECT AVG(total_amount) AS avg_order_value FROM Orders WHERE total_amount > 0;

-- 23) Number of products per supplier
SELECT s.name AS supplier_name, COUNT(p.product_id) AS product_count
FROM Suppliers s
LEFT JOIN Products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.name
ORDER BY product_count DESC;

-- 24) Recent 10 orders with customer name and store
SELECT o.order_id, o.order_date, c.name AS customer_name, st.store_name, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Stores st ON o.store_id = st.store_id
ORDER BY o.order_date DESC
LIMIT 10;

-- 25) Total number of customers per city
SELECT city, COUNT(*) AS customers_count FROM Customers GROUP BY city ORDER BY customers_count DESC;

-- 26) Find orders with mismatch (order total = 0 or suspicious)
SELECT * FROM Orders WHERE total_amount = 0.00;

-- 27) Top 5 selling products by quantity (from Order_Items)
SELECT p.name, SUM(oi.quantity) AS total_qty
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_qty DESC
LIMIT 5;

-- 28) Get payment methods distribution
SELECT method, COUNT(*) AS count_payments, SUM(amount) AS total_amount
FROM Payments
GROUP BY method
ORDER BY count_payments DESC;

-- 29) Deliveries due in next 3 days
SELECT delivery_id, order_id, expected_delivery_date, status
FROM Deliveries
WHERE expected_delivery_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY);

-- 30) Simple join: Show product, supplier and category
SELECT p.name AS product, s.name AS supplier, c.category_name
FROM Products p
JOIN Suppliers s ON p.supplier_id = s.supplier_id
JOIN Categories c ON p.category_id = c.category_id
ORDER BY p.name;

