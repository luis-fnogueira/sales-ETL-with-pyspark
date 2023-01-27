-- This code creates the customer dimensions of our DW

CREATE TABLE IF NOT EXISTS customer_dimension (

	id SERIAL PRIMARY KEY,
	customer_name VARCHAR(256),
	customer_lastname VARCHAR(256)

)

