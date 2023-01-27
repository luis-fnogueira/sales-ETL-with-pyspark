-- This tables serves as source to customer_city and customer_state columns
-- The CSV was downloaded from https://raw.githubusercontent.com/grammakov/USA-cities-and-states/master/us_cities_states_counties.csv

CREATE table sales.addresses (
	city VARCHAR(256),
	state_short VARCHAR(256)
)