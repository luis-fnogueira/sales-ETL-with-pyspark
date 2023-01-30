-- This table is the fact table of our warehouse


CREATE TABLE IF NOT EXISTS fact_table (

	id SERIAL PRIMARY KEY,
	order_id INT,
	customer_id INT,
	address_id INT, 
	quantity INT,
	order_value INT,
	order_date DATE,
	product_id INT

)

