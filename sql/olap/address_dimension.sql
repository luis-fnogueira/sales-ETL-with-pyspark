-- This code creates the customer dimensions of our DW

CREATE TABLE IF NOT EXISTS address_dimension (

	id SERIAL PRIMARY KEY,
	city VARCHAR(256),
	state VARCHAR(256)

)
