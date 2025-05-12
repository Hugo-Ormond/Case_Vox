

CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER dbinterview_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'localhost', dbname 'dbinterview', port '5432');

CREATE USER MAPPING FOR postgres
    SERVER dbinterview_server
    OPTIONS (user 'postgres', password '');
	
	
	
----------------------------------------

CREATE FOREIGN TABLE rental_ext (
    rental_id INTEGER,
    rental_date TIMESTAMP WITHOUT TIME ZONE,
    inventory_id INTEGER,
    customer_id SMALLINT,
    return_date TIMESTAMP WITHOUT TIME ZONE,
    staff_id SMALLINT,
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'rental');


CREATE FOREIGN TABLE actor_ext (
    actor_id INTEGER,
    first_name VARCHAR,
    last_name VARCHAR,
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'actor');



CREATE FOREIGN TABLE store_ext (
    store_id INTEGER,
    manager_staff_id SMALLINT,
    address_id SMALLINT,
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'store');



CREATE FOREIGN TABLE staff_ext (
    staff_id INTEGER,
    first_name VARCHAR,
    last_name VARCHAR,
    address_id SMALLINT,
    email VARCHAR,
    store_id SMALLINT,
    active BOOLEAN,
    username VARCHAR,
    password VARCHAR,
    last_update TIMESTAMP WITHOUT TIME ZONE,
    picture BYTEA
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'staff');



CREATE FOREIGN TABLE payment_ext (
    payment_id INTEGER,
    customer_id SMALLINT,
    staff_id SMALLINT,
    rental_id INTEGER,
    amount NUMERIC,
    payment_date TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'payment');



CREATE FOREIGN TABLE language_ext (
    language_id INTEGER,
    name VARCHAR,  -- Corrigido aqui!
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'language');




CREATE FOREIGN TABLE inventory_ext (
    inventory_id INTEGER,
    film_id SMALLINT,
    store_id SMALLINT,
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'inventory');



CREATE FOREIGN TABLE customer_ext (
    customer_id INTEGER,
    store_id SMALLINT,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    address_id SMALLINT,
    activebool BOOLEAN,
    create_date DATE,
    last_update TIMESTAMP WITHOUT TIME ZONE,
    active INTEGER
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'customer');



CREATE FOREIGN TABLE film_ext (
    film_id INTEGER,
    title VARCHAR,
    description TEXT,
    release_year SMALLINT,
    language_id SMALLINT,
    rental_duration SMALLINT,
    rental_rate NUMERIC,
    length SMALLINT,
    replacement_cost NUMERIC,
    rating VARCHAR,
    last_update TIMESTAMP WITHOUT TIME ZONE,
    special_features VARCHAR[],  -- Tipo ARRAY de texto
    fulltext TSVECTOR  -- Tipo tsvector para pesquisa de texto completo
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'film');


CREATE FOREIGN TABLE film_actor_ext (
    actor_id SMALLINT,
    film_id SMALLINT,
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'film_actor');


CREATE FOREIGN TABLE film_category_ext (
    film_id SMALLINT,
    category_id SMALLINT,
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'film_category');


CREATE FOREIGN TABLE city_ext (
    city_id INTEGER,
    city VARCHAR,
    country_id SMALLINT,
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'city');


CREATE FOREIGN TABLE category_ext (
    category_id INTEGER,
    name VARCHAR,
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'category');


CREATE FOREIGN TABLE address_ext (
    address_id INTEGER,
    address VARCHAR,
    address2 VARCHAR,
    district VARCHAR,
    city_id SMALLINT,
    postal_code VARCHAR,
    phone VARCHAR,
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'address');


CREATE FOREIGN TABLE country_ext (
    country_id INTEGER,
    country VARCHAR,
    last_update TIMESTAMP WITHOUT TIME ZONE
)
SERVER dbinterview_server
OPTIONS (schema_name 'public', table_name 'country');


-----------------------------------

-- 1. country
DELETE FROM country;
INSERT INTO country SELECT * FROM country_ext;

-- 2. city
DELETE FROM city;
INSERT INTO city SELECT * FROM city_ext;

-- 3. address
DELETE FROM address;
INSERT INTO address SELECT * FROM address_ext;

-- 4. language
DELETE FROM language;
INSERT INTO language SELECT * FROM language_ext;

-- 5. category
DELETE FROM category;
INSERT INTO category SELECT * FROM category_ext;

-- 6. actor
DELETE FROM actor;
INSERT INTO actor SELECT * FROM actor_ext;

-- 7. staff
DELETE FROM staff;
INSERT INTO staff SELECT * FROM staff_ext;

-- 8. store
DELETE FROM store;
INSERT INTO store SELECT * FROM store_ext;

-- 9. customer
DELETE FROM customer;
INSERT INTO customer SELECT * FROM customer_ext;

-- 10. film
DELETE FROM film;
INSERT INTO film SELECT * FROM film_ext;

-- 11. film_category
DELETE FROM film_category;
INSERT INTO film_category SELECT * FROM film_category_ext;

-- 12. film_actor
DELETE FROM film_actor;
INSERT INTO film_actor SELECT * FROM film_actor_ext;

-- 13. inventory
DELETE FROM inventory;
INSERT INTO inventory SELECT * FROM inventory_ext;

-- 14. rental
DELETE FROM rental;
INSERT INTO rental SELECT * FROM rental_ext;

-- 15. payment
DELETE FROM payment;
INSERT INTO payment SELECT * FROM payment_ext;