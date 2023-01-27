DO $$
	BEGIN
	FOR i in 1..50000 LOOP
	
	INSERT INTO sales.sales (	
	 quantity,
	 order_value,
	 order_date
	) VALUES(

	(SELECT floor(random() * 100 + 1)),
	(SELECT floor(random() * 50000 + 1)),
	(SELECT CAST(now() - random() * INTERVAL '365 days' as date)));
	
	END LOOP;
END;
$$;