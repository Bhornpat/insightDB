-- Set up all InsightDB tables

-- ========================
-- TABLE: customers
-- ========================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    location VARCHAR(100),
    joined_date DATE DEFAULT CURRENT_DATE
);

-- ========================
-- TABLE: products
-- ========================
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0)
);

-- ========================
-- TABLE: orders
-- ========================
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE DEFAULT CURRENT_DATE,
    total_amount NUMERIC(10, 2) DEFAULT 0 CHECK (total_amount >= 0),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- ========================
-- TABLE: order_items
-- ========================
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_each NUMERIC(10, 2) NOT NULL CHECK (price_each >= 0),
    
    CONSTRAINT fk_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES products(product_id) ON DELETE CASCADE
);

-- ========================
-- TABLE: employees
-- ========================
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    hire_date DATE DEFAULT CURRENT_DATE
);

-- ========================
-- TABLE: shippers
-- ========================
CREATE TABLE shippers (
    shipper_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);

-- ========================
-- TABLE: shipping
-- ========================
CREATE TABLE shipping (
    shipping_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    shipper_id INT NOT NULL,
    shipped_date DATE,
    delivery_status VARCHAR(50) DEFAULT 'Pending',

    CONSTRAINT fk_shipping_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_shipping_shipper FOREIGN KEY (shipper_id)
        REFERENCES shippers(shipper_id) ON DELETE SET NULL
);

-- OPTIONAL INDEXES
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_shipping_order_id ON shipping(order_id);
CREATE INDEX idx_shipping_shipper_id ON shipping(shipper_id);
