# Online Retail Store Management System (MySQL)

## Project Overview
This project is a **MySQL-based Online Retail Store Management System** designed to simulate the backend database of an e-commerce platform. It manages products, customers, orders, payments, shipping, employees, and inventory, providing a full lifecycle of retail operations.

## Features
- **Database Design:** 10 relational tables including `Customers`, `Products`, `Orders`, `Order_Items`, `Payments`, `Shipping`, `Employees`, `Categories`, `Suppliers`, and `Inventory_Log`.
- **Data Integrity:** Enforced with **primary keys, foreign keys, constraints**, and **data types** to maintain consistency.
- **Automation & Business Logic:**
  - Triggers to automatically update inventory when an order is placed.
  - Stored procedure `place_order` to handle order placement and stock adjustments.
- **Sample Data:** Preloaded with customers, products, orders, payments, shipping, and inventory logs to simulate real-world transactions.
- **Reports & Analysis:**
  - Revenue per month for the last 12 months.
  - Total sales per product and top customers by spend.
  - Low-stock product alerts.
  - Orders without payment and employees handling most shipments.
- **CRUD Operations:** Examples provided for creating, reading, updating, and deleting products.

## Tools & Technologies
- **Database:** MySQL
- **SQL Concepts Used:** Joins, Subqueries, Aggregate Functions (`SUM`, `COUNT`), `GROUP BY`, `ORDER BY`, Triggers, Stored Procedures, Transactions, JSON handling.

## Use Cases
- Manage online retail operations and track product inventory.
- Monitor customer purchases, payments, and order shipments.
- Generate business reports for revenue analysis and decision-making.
- Automate stock management using triggers and procedures.

## How to Run
1. Install MySQL and create a new database.
2. Execute the full SQL script to create tables, insert sample data, triggers, and procedures.
3. Run queries or call the stored procedure `place_order` to simulate orders.
4. Use example queries to generate reports and insights.
