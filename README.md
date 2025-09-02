# 🛒 Online Retail Store Management System (MySQL)

[![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)  
[![SQL](https://img.shields.io/badge/SQL-00758F?style=for-the-badge&logo=sql&logoColor=white)](https://www.mysql.com/)

---

## 🚀 Project Overview
A **MySQL-based Online Retail Store Management System** to simulate a real-world e-commerce store.  
It manages **customers, products, suppliers, orders, payments, shipping, and inventory** using relational database structures.  
Includes **stored procedures, triggers, transactions, and analytical queries** for end-to-end retail operations.  

---

## 🗂️ Database Structure

**Database Name:** `Online_Retail`  

**Tables:**  
- **Customers** – Customer details with contact info and address.  
- **Categories** – Product categories with descriptions.  
- **Suppliers** – Supplier information.  
- **Products** – Catalog of products with stock, price, and category.  
- **Employees** – Staff handling orders and shipping.  
- **Orders** – Customer orders with status and total amount.  
- **Order_Items** – Items in each order.  
- **Payments** – Payment details for orders.  
- **Shipping** – Shipping info including assigned employee and tracking.  
- **Inventory_Log** – Tracks stock changes (IN, OUT, ADJUST).  

---

## ⚙️ Key Features

### Stored Procedure
- **`place_order`** – Handles transactional order placement and returns order ID.  

### Trigger
- **`trg_after_order_item_insert`** – Automatically updates stock and logs inventory changes when a new order item is inserted.  

### Analytics Queries
- Total sales per product  
- Monthly revenue report  
- Top 5 customers by spend  
- Products low on stock  
- Employees handling most shipments  
- Orders without payments  

### CRUD Operations
- Add, read, update, and delete products  
- Supports soft delete using `is_active` flag  

---

## 💾 Sample Data
- Categories: Electronics, Apparel, Home & Kitchen, Sports, Books, Toys, Beauty, Furniture, Groceries, Automotive  
- Products: Smartphones, laptops, clothing, kitchen appliances, toys, books, beauty products, furniture, groceries  
- Customers & Employees: Realistic sample data to simulate store operations  

---

## 🛠️ Technologies & Concepts Used
- **MySQL 8+**  
- Relational database design with **primary/foreign keys, constraints, indexes**  
- **Transactions** for safe order processing  
- **Stored procedures & triggers**  
- Aggregate functions, **GROUP BY, JOINs**, and complex queries  

---

## 🎯 Project Benefits
- Demonstrates **real-world retail database operations**.  
- Helps understand **inventory, order, payment, and shipping workflows**.  
- Ideal for learning **advanced MySQL features** like triggers, stored procedures, and transactions.  
