
CREATE TABLE cdc_control (
    table_name VARCHAR PRIMARY KEY,
    last_processed TIMESTAMP WITHOUT TIME ZONE
);

INSERT INTO cdc_control (table_name, last_processed)
VALUES ('customer', '2000-01-01 00:00:00'),
       ('rental', '2000-01-01 00:00:00');

-------------------


-- Função para capturar as alterações de 'customer'
CREATE OR REPLACE FUNCTION capture_customer_changes() RETURNS void AS $$
DECLARE
    last_processed_time TIMESTAMP;
BEGIN
    -- Recupera o último processamento da tabela 'customer'
    SELECT last_processed INTO last_processed_time
    FROM cdc_control
    WHERE table_name = 'customer';

    -- Insere as mudanças (inserções/atualizações) desde o último processamento
    INSERT INTO customer_ext (customer_id, first_name, last_name, email, address_id, activebool, create_date, last_update)
    SELECT
        customer_id,
        first_name,
        last_name,
        email,
        address_id,
        activebool,
        create_date,
        last_update
    FROM customer
    WHERE last_update > last_processed_time;

    -- Atualiza a data de processamento para a mais recente encontrada
    UPDATE cdc_control
    SET last_processed = (SELECT MAX(last_update) FROM customer)
    WHERE table_name = 'customer';
END;
$$ LANGUAGE plpgsql;


---------------

-- Função para capturar as alterações de 'rental'
CREATE OR REPLACE FUNCTION capture_rental_changes() RETURNS void AS $$
DECLARE
    last_processed_time TIMESTAMP;
BEGIN
    -- Recupera o último processamento da tabela 'rental'
    SELECT last_processed INTO last_processed_time
    FROM cdc_control
    WHERE table_name = 'rental';

    -- Insere as mudanças (inserções/atualizações) desde o último processamento
    INSERT INTO rental_ext (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
    SELECT
        rental_id,
        rental_date,
        inventory_id,
        customer_id,
        return_date,
        staff_id,
        last_update
    FROM rental
    WHERE last_update > last_processed_time;

    -- Atualiza a data de processamento para a mais recente encontrada
    UPDATE cdc_control
    SET last_processed = (SELECT MAX(last_update) FROM rental)
    WHERE table_name = 'rental';
END;
$$ LANGUAGE plpgsql;

