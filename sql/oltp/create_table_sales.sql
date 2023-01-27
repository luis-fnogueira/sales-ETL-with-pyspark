-- This code creates the table where data will be extracted

CREATE TABLE IF NOT EXISTS sales(

    order_id INT NOT NULL UNIQUE,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    customer_name VARCHAR(256) NOT NULL,
    customer_lastname VARCHAR(256) NOT NULL,
    customer_city VARCHAR(256) NOT NULL,
    customer_state VARCHAR(256) NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_value FLOAT NOT NULL

);


