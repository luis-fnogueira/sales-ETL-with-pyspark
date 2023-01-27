-- This query populates the address dimension and creates an ID for each one


INSERT INTO sales.customer_dimension  (customer_name, customer_lastname) 

	SELECT customer_name, customer_lastname from sales.sales
