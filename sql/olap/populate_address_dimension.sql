-- This query populates the address dimension and creates an ID for each one

INSERT INTO address_dimension (city, state) 

	SELECT customer_city, customer_state from sales.sales