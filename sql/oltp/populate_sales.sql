-- This code populates the table where data will be extracted

DO $$
	BEGIN
	FOR i in 1..10000 LOOP
	
	INSERT INTO sales.sales (	
	 quantity,
	 order_value,
	 order_date,
	 customer_name,
	 customer_lastname,
	 customer_city,
	 customer_state
	) VALUES(

	(SELECT floor(random() * 100 + 1)),
	(SELECT floor(random() * 50000 + 1)),
	(SELECT CAST(now() - random() * INTERVAL '365 days' as date)),
	(SELECT first_name FROM sales.names ORDER BY random() LIMIT 1),
	(SELECT last_name FROM sales.names ORDER BY random() LIMIT 1),
	(SELECT city FROM sales.addresses ORDER BY random() LIMIT 1),
	(SELECT "State short" FROM sales.addresses ORDER BY random() LIMIT 1)
	);
	
	END LOOP;
END;
$$;