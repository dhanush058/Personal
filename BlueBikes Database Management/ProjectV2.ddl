SET AUTOCOMMIT ON;

BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE maintenanceID START WITH 1 INCREMENT BY 1';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence maintenanceID already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE bikeID START WITH 1 INCREMENT BY 1';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence bikeID already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE cardID START WITH 1 INCREMENT BY 1';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence cardID already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE customerID START WITH 1 INCREMENT BY 1';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence customerID already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE FeeID START WITH 1 INCREMENT BY 1';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence FeeID already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE stationID START WITH 1 INCREMENT BY 1';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence stationID already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE tripID START WITH 1 INCREMENT BY 1';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence tripID already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

-- Create all tables
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE maintenance_log (
        log_id               NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1) PRIMARY KEY,
        maintenance_id       NUMBER NOT NULL,
        bike_id              NUMBER NOT NULL,
        start_of_maintenance DATE,
        end_of_maintenance   DATE,
        description          VARCHAR2(50),
        maintenance_operator VARCHAR2(50),
        log_time             DATE NOT NULL

    )';
    EXECUTE IMMEDIATE 'ALTER TABLE maintenance_log ADD (bike_id NUMBER);
';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table maintenance_log already exists.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE maintenance_log ADD (DESCRIPTION VARCHAR2(255))';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01430 THEN
            DBMS_OUTPUT.PUT_LINE('Column DESCRIPTION already exists.');
        ELSE
            RAISE;
        END IF;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE maintenance_log ADD (MAINTENANCE_OPERATOR VARCHAR2(50))';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01430 THEN
            DBMS_OUTPUT.PUT_LINE('Column MAINTENANCE_OPERATOR already exists.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE maintenance_log ADD (START_OF_MAINTENANCE DATE)';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01430 THEN
            DBMS_OUTPUT.PUT_LINE('Column START_OF_MAINTENANCE already exists.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE maintenance_log ADD (END_OF_MAINTENANCE DATE)';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01430 THEN
            DBMS_OUTPUT.PUT_LINE('Column END_OF_MAINTENANCE already exists.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE maintenance_log ADD (DESCRIPTION VARCHAR2(255))';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01430 THEN
            DBMS_OUTPUT.PUT_LINE('Column DESCRIPTION already exists.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE maintenance_log ADD (BIKE_ID NUMBER)';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01430 THEN
            DBMS_OUTPUT.PUT_LINE('Column BIKE_ID already exists.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE maintenance_log ADD (MAINTENANCE_ID NUMBER)';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01430 THEN
            DBMS_OUTPUT.PUT_LINE('Column MAINTENANCE_ID already exists.');
        ELSE
            RAISE;
        END IF;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE bikes (
        bike_id       NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
        model         VARCHAR2(50),
        status        VARCHAR2(50),
        location_id   NUMBER, -- Adjusted data type to NUMBER
        purchase_date DATE,
        CONSTRAINT fk_location FOREIGN KEY (location_id) REFERENCES stations(station_id)
    )';
    DBMS_OUTPUT.PUT_LINE('Table "bikes" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table bikes already exists. Skipping creation.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            RAISE;
        END IF;
END;
/



BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE card (
        card_id     NUMBER DEFAULT cardID.NEXTVAL NOT NULL,
        card_number NUMBER,
        card_expiry DATE,
        card_ssn    NUMBER,
        customer_id NUMBER NOT NULL
    )';
    EXECUTE IMMEDIATE 'ALTER TABLE card ADD CONSTRAINT card_pk PRIMARY KEY (card_id)';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table card already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE card_audit_log (
        log_id          NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1) PRIMARY KEY,
        card_id         NUMBER NOT NULL,
        old_card_number VARCHAR2(16),
        new_card_number VARCHAR2(16),
        change_date     DATE NOT NULL,
        action_type     VARCHAR2(10) NOT NULL
    )';
    DBMS_OUTPUT.PUT_LINE('Card_audit_log table created successfully.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Card_audit_log table already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE customer_activity_log (
        log_id       NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1) PRIMARY KEY,
        trip_id      NUMBER NOT NULL,
        customer_id  NUMBER NOT NULL,
        start_time   DATE NOT NULL,
        end_time     DATE
    )';
    DBMS_OUTPUT.PUT_LINE('Table customer_activity_log created successfully.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table customer_activity_log already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE customers (
        customer_id NUMBER DEFAULT customerID.NEXTVAL NOT NULL,
        first_name  VARCHAR2(50) NOT NULL,
        last_name   VARCHAR2(50) NOT NULL,
        email       VARCHAR2(50) NOT NULL,
        phone       NUMBER NOT NULL,
        status      VARCHAR2(50) DEFAULT ''Active''
    )';
    EXECUTE IMMEDIATE 'ALTER TABLE customers ADD CONSTRAINT customers_pk PRIMARY KEY (customer_id)';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table customers already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE fee_changes_log (
        log_id            NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1) PRIMARY KEY,
        fee_id            NUMBER NOT NULL,
        old_fee_per_hour  NUMBER,
        new_fee_per_hour  NUMBER,
        change_date       DATE NOT NULL
    )';
    DBMS_OUTPUT.PUT_LINE('Table fee_changes_log created successfully.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table fee_changes_log already exists.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE fees (
        fee_id                 NUMBER DEFAULT FeeID.NEXTVAL NOT NULL,
        trip_id                NUMBER, -- Added trip_id column
        fee_per_hour           NUMBER,
        date_of_implementation DATE,
        CONSTRAINT fees_pk PRIMARY KEY (fee_id),
        CONSTRAINT fk_trip FOREIGN KEY (trip_id) REFERENCES TRIPS (trip_id) 
    )';
    DBMS_OUTPUT.PUT_LINE('Table "fees" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table fees already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE maintenance PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('Table maintenance does not exist, creating new.');
        ELSE
            RAISE;
        END IF;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE maintenance (
        maintenance_id       NUMBER DEFAULT maintenanceID.NEXTVAL NOT NULL,
        bike_id              NUMBER NOT NULL,
        start_of_maintenance DATE,
        end_of_maintenance   DATE,
        description          VARCHAR2(50),
        MAINTENANCE_OPERATOR VARCHAR2(50),
        CONSTRAINT maintenance_pk PRIMARY KEY (maintenance_id),
        CONSTRAINT maintenance_bikes_fk FOREIGN KEY (bike_id) REFERENCES bikes (bike_id)
    )';
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating table maintenance: ' || SQLERRM);
        RAISE;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE maintenance ADD (MAINTENANCE_OPERATOR VARCHAR2(50))';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01430 THEN
            DBMS_OUTPUT.PUT_LINE('Column MAINTENANCE_OPERATOR already exists in maintenance table.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE stations (
        station_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
        name       VARCHAR2(50),
        location   VARCHAR2(50),
        capacity   NUMBER
    )';
    DBMS_OUTPUT.PUT_LINE('Table "stations" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN -- ORA-00955: name is already used by an existing object
            DBMS_OUTPUT.PUT_LINE('Table stations already exists. Skipping creation.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error creating stations table: ' || SQLERRM);
            RAISE;
        END IF;
END;
/

BEGIN
    -- Drop the trips table if it exists
    EXECUTE IMMEDIATE 'DROP TABLE trips CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table "TRIPS" dropped successfully.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN -- Table does not exist
            DBMS_OUTPUT.PUT_LINE('Table "TRIPS" does not exist, creating new.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE TRIPS (
    trip_id               NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    start_time            DATE NOT NULL,
    end_time              DATE,
    bikes_bike_id         NUMBER NOT NULL,
    customers_customer_id NUMBER NOT NULL,
    start_station_id      NUMBER NOT NULL,
    end_station_id        NUMBER,
    trip_paid             VARCHAR2(50),
    CONSTRAINT fk_bikes FOREIGN KEY (bikes_bike_id) REFERENCES BIKES (bike_id),
        CONSTRAINT fk_customers FOREIGN KEY (customers_customer_id) REFERENCES CUSTOMERS (customer_id),
        CONSTRAINT trips_stations_fk FOREIGN KEY (end_station_id) REFERENCES STATIONS (station_id),
        CONSTRAINT trips_stations_fkv1 FOREIGN KEY (start_station_id) REFERENCES STATIONS (station_id)
)';
    DBMS_OUTPUT.PUT_LINE('Table "TRIPS" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/

DROP TABLE trip_fee_mapping; 

CREATE TABLE trip_fee_mapping (
    trip_id NUMBER,
    fee_id NUMBER,
    CONSTRAINT trip_fee_mapping_fk_trip FOREIGN KEY (trip_id) REFERENCES trips (trip_id),
    CONSTRAINT trip_fee_mapping_fk_fee FOREIGN KEY (fee_id) REFERENCES fees (fee_id)
);


-- Create all views
BEGIN
    EXECUTE IMMEDIATE 'CREATE VIEW Bike_count_per_station AS
    SELECT s.station_id,
           s.name AS station_name,
           COUNT(b.bike_id) AS bike_count
    FROM stations s
    LEFT JOIN bikes b ON s.name = b.location_id
    GROUP BY s.station_id, s.name';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('View Bike_count_per_station already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE VIEW Total_trips_per_month AS
    SELECT TO_CHAR(start_time, ''YYYY-MM'') AS trip_month,
           COUNT(*) AS total_trips
    FROM trips
    GROUP BY TO_CHAR(start_time, ''YYYY-MM'')';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('View Total_trips_per_month already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE '
    CREATE OR REPLACE VIEW Maintenance_per_bike AS
    SELECT b.bike_id,
           b.model,
           m.start_of_maintenance,
           m.end_of_maintenance,
           m.description,
           m.maintenance_operator
    FROM bikes b
    LEFT JOIN maintenance m ON b.bike_id = m.bike_id';
    DBMS_OUTPUT.PUT_LINE('View Maintenance_per_bike created or replaced successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in creating view Maintenance_per_bike: ' || SQLERRM);
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW Trips_started_at_each_station AS
        SELECT start_station_id AS station_id,
               COUNT(trip_id) AS trips_started
        FROM trips
        GROUP BY start_station_id
        ORDER BY start_station_id';
    DBMS_OUTPUT.PUT_LINE('View Trips_started_at_each_station created successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating view Trips_started_at_each_station: ' || SQLERRM);
        RAISE;
END;
/


BEGIN
    EXECUTE IMMEDIATE '
    CREATE VIEW Trips_ended_at_each_station AS
    SELECT end_station_id AS station_id,
           COUNT(trip_id) AS trips_ended
    FROM trips
    GROUP BY end_station_id
    ORDER BY end_station_id';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('View Trips_ended_at_each_station already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE '
    CREATE VIEW Customer_rental_history AS
    SELECT c.customer_id,
           c.first_name || '' '' || c.last_name AS customer_name,
           t.trip_id,
           t.start_time,
           t.end_time,
           t.start_station_id AS start_station,
           t.end_station_id AS end_station,
           t.trip_paid
    FROM customers c
    JOIN trips t ON c.customer_id = t.customers_customer_id';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('View Customer_rental_history already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE '
    CREATE VIEW Customer_membership_status AS
    SELECT c.customer_id,
           c.first_name || '' '' || c.last_name AS customer_name,
           CASE
               WHEN cr.card_id IS NOT NULL THEN ''Active''
               ELSE ''Inactive''
           END AS membership_status
    FROM customers c
    LEFT JOIN card cr ON c.customer_id = cr.customer_id';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('View Customer_membership_status already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE '
    CREATE VIEW Unreturned_bikes AS
    SELECT t.trip_id,
           t.start_time AS rental_start_time,
           t.bikes_bike_id AS bike_id,
           c.customer_id AS customer_id,
           c.first_name || '' '' || c.last_name AS customer_name,
           t.start_station_id AS rented_from_station_id,
           s1.name AS rented_from_station_name
    FROM trips t
    INNER JOIN customers c ON t.customers_customer_id = c.customer_id
    INNER JOIN stations s1 ON t.start_station_id = s1.station_id
    LEFT JOIN stations s2 ON t.end_station_id = s2.station_id
    WHERE t.end_time IS NULL';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('View Unreturned_bikes already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE VIEW Average_trip_duration_per_bike AS
    SELECT t.bikes_bike_id AS bike_id,
           TRUNC(AVG(diff_minutes) / 60) || '' hours '' ||
           MOD(AVG(diff_minutes), 60) || '' minutes'' AS average_duration
    FROM (SELECT bikes_bike_id,
                 (MAX(end_time) - MIN(start_time)) * 24 * 60 AS diff_minutes
          FROM trips
          GROUP BY bikes_bike_id) t
    GROUP BY t.bikes_bike_id';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('View Average_trip_duration_per_bike already exists. Skipping creation.');
        ELSE
            RAISE;
        END IF;
END;
/

-- grants on views
GRANT SELECT ON AVERAGE_TRIP_DURATION_PER_BIKE TO system_admin, maintenance_user, bike_user;
GRANT SELECT ON BIKE_COUNT_PER_STATION TO system_admin, maintenance_user, bike_user;
GRANT SELECT ON CUSTOMER_MEMBERSHIP_STATUS TO system_admin;
GRANT SELECT ON CUSTOMER_RENTAL_HISTORY TO system_admin;
GRANT SELECT ON MAINTENANCE_PER_BIKE TO system_admin, maintenance_user;
GRANT SELECT ON TOTAL_TRIPS_PER_MONTH TO system_admin, maintenance_user;
GRANT SELECT ON TRIPS_ENDED_AT_EACH_STATION TO system_admin, maintenance_user;
GRANT SELECT ON TRIPS_STARTED_AT_EACH_STATION TO system_admin, maintenance_user;
GRANT SELECT ON UNRETURNED_BIKES TO system_admin, maintenance_user;

-- Create Triggers
CREATE OR REPLACE TRIGGER check_duplicate_customer
BEFORE INSERT ON customers
FOR EACH ROW
DECLARE
    phone_exists NUMBER;
    email_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO phone_exists FROM customers WHERE phone = :new.phone;
    SELECT COUNT(*) INTO email_exists FROM customers WHERE email = :new.email;

    IF phone_exists > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'A customer with this phone number already exists.');
    ELSIF email_exists > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'A customer with this email already exists.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER UPDATE_BIKE_COUNT
AFTER INSERT OR DELETE ON bikes
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE stations SET capacity = capacity + 1 WHERE station_id = :new.location_id;
    ELSIF DELETING THEN
        UPDATE stations SET capacity = capacity - 1 WHERE station_id = :old.location_id;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER mark_bike_maintenance
AFTER INSERT ON maintenance
FOR EACH ROW
BEGIN
    UPDATE bikes
    SET status = 'Under Maintenance'
    WHERE bike_id = :new.bike_id;  
END;
/


CREATE OR REPLACE TRIGGER update_bike_status
AFTER INSERT OR UPDATE OF end_time ON trips
FOR EACH ROW
BEGIN
    IF :new.end_time IS NULL THEN
        UPDATE bikes
        SET status = 'In Use'
        WHERE bike_id = :new.bikes_bike_id;
    ELSE
        UPDATE bikes
        SET status = 'Available'
        WHERE bike_id = :new.bikes_bike_id;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_bike_availability
BEFORE INSERT ON trips
FOR EACH ROW
DECLARE
    v_bike_status bikes.status%TYPE;
BEGIN
    IF :new.end_time IS NULL THEN
        SELECT status INTO v_bike_status
        FROM bikes
        WHERE bike_id = :new.bikes_bike_id;
        
        IF v_bike_status != 'Available' THEN
            RAISE_APPLICATION_ERROR(-20001, 'Selected bike is not available for rent.');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_bikemaintenance_log
AFTER INSERT OR UPDATE ON maintenance
FOR EACH ROW
BEGIN
    INSERT INTO maintenance_log (
        maintenance_id, 
        bike_id, 
        start_of_maintenance, 
        end_of_maintenance, 
        description, 
        maintenance_operator, 
        log_time
    ) VALUES (
        :new.maintenance_id, 
        :new.bike_id, 
        :new.start_of_maintenance, 
        :new.end_of_maintenance, 
        :new.description, 
        :new.maintenance_operator, 
        SYSDATE
    );
END;
/


CREATE OR REPLACE TRIGGER trg_fee_change_log
AFTER UPDATE OF fee_per_hour ON fees
FOR EACH ROW
BEGIN
    INSERT INTO fee_changes_log (fee_id, old_fee_per_hour, new_fee_per_hour, change_date)
    VALUES (:old.fee_id, :old.fee_per_hour, :new.fee_per_hour, SYSDATE);
END;
/

CREATE OR REPLACE TRIGGER trg_log_customer_trip
AFTER INSERT or update ON trips
FOR EACH ROW
BEGIN
    INSERT INTO customer_activity_log (trip_id, customer_id, start_time, end_time)
    VALUES (:new.trip_id, :new.customers_customer_id, :new.start_time, :new.end_time);
END;
/

CREATE OR REPLACE TRIGGER trg_card_advanced
BEFORE INSERT OR UPDATE ON card
FOR EACH ROW
DECLARE
    cardNumLength NUMBER;
BEGIN
    -- Basic validation for card number length
    cardNumLength := LENGTH(TO_CHAR(:new.card_number));
    IF cardNumLength < 16 OR cardNumLength > 16 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Card number must be 16 digits.');
    END IF;

    IF UPDATING THEN
        -- Conditional logging: Log only if card number changes, and mask card number
        IF :old.card_number <> :new.card_number THEN
            INSERT INTO card_audit_log (card_id, old_card_number, new_card_number, change_date, action_type)
            VALUES (:old.card_id, SUBSTR(TO_CHAR(:old.card_number), -4), SUBSTR(TO_CHAR(:new.card_number), -4), SYSDATE, 'UPDATE');
        END IF;
    ELSIF DELETING THEN
        -- For deletion, log the action with masked card number
        INSERT INTO card_audit_log (card_id, old_card_number, change_date, action_type)
        VALUES (:old.card_id, SUBSTR(TO_CHAR(:old.card_number), -4), SYSDATE, 'DELETE');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_prevent_open_trip
BEFORE INSERT ON trips
FOR EACH ROW
DECLARE
    v_open_trip_count NUMBER;
BEGIN
    -- Check if the customer already has an open trip
    SELECT COUNT(*)
    INTO v_open_trip_count
    FROM trips
    WHERE customers_customer_id = :NEW.customers_customer_id
      AND end_time IS NULL; -- Assumes an open trip doesn't have an end time

    IF v_open_trip_count > 0 THEN
        -- Customer already has an open trip, raise an exception to prevent the new trip insertion
        RAISE_APPLICATION_ERROR(-20001, 'Customer already has an open trip. Cannot open a new trip.');
    END IF;
END;
/

--check_bike_availability_procedure
CREATE OR REPLACE PROCEDURE check_bike_availability_procedure (
    new_bike_id IN trips.bikes_bike_id%TYPE,
    new_end_time IN trips.end_time%TYPE
)
AS
    v_bike_status bikes.status%TYPE;
BEGIN
    IF new_end_time IS NULL THEN
        SELECT status INTO v_bike_status
        FROM bikes
        WHERE bike_id = new_bike_id;
        
        IF v_bike_status != 'Available' THEN
            RAISE_APPLICATION_ERROR(-20001, 'Selected bike is not available for rent.');
        END IF;
    END IF;
END check_bike_availability_procedure;
/

-- Create or replace the procedure to update the end of maintenance in a maintenance log entry
CREATE OR REPLACE PROCEDURE update_end_of_maintenance (
    maintenance_log_id IN maintenance_log.maintenance_id%TYPE,
    new_end_of_maintenance IN maintenance_log.end_of_maintenance%TYPE
)
AS
BEGIN
    UPDATE maintenance
    SET end_of_maintenance = new_end_of_maintenance
    WHERE maintenance_id = maintenance_log_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('End of maintenance updated successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No maintenance log entry found with ID ' || maintenance_log_id);
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--fee_change_procedure
CREATE OR REPLACE PROCEDURE fee_change_procedure (
    new_fee_per_hour IN fees.fee_per_hour%TYPE,
    new_date_of_implementation IN fees.date_of_implementation%TYPE
)
AS
BEGIN
    INSERT INTO fees (fee_per_hour, date_of_implementation)
    VALUES (new_fee_per_hour, new_date_of_implementation);
END fee_change_procedure;
/

-- Create or replace the procedure to insert a new customer
CREATE OR REPLACE PROCEDURE create_new_customer (
    new_first_name IN customers.first_name%TYPE,
    new_last_name IN customers.last_name%TYPE,
    new_email IN customers.email%TYPE,
    new_phone IN customers.phone%TYPE,
    new_card_number IN card.card_number%TYPE,
    new_card_expiry IN card.card_expiry%TYPE,
    new_card_ssn IN card.card_ssn%TYPE
)
AS
    v_customer_id customers.customer_id%TYPE;  -- Define a variable to hold customer_id
BEGIN
    -- Insert into customers table
    INSERT INTO customers (first_name, last_name, email, phone)
    VALUES (new_first_name, new_last_name, new_email, new_phone)
    RETURNING customer_id INTO v_customer_id;  -- Retrieve the generated customer_id

    -- Insert into card table using the retrieved customer_id
    INSERT INTO card (card_number, card_expiry, card_ssn, customer_id)
    VALUES (new_card_number, new_card_expiry, new_card_ssn, v_customer_id);

    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('New customer created successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END create_new_customer;
/

CREATE OR REPLACE PROCEDURE new_trip (
    new_bike_id IN trips.bikes_bike_id%TYPE,
    new_customer_id IN trips.customers_customer_id%TYPE,
    new_start_station_id IN trips.start_station_id%TYPE
) AS
BEGIN
    INSERT INTO trips (start_time, bikes_bike_id, customers_customer_id, start_station_id)
    VALUES (SYSDATE, new_bike_id, new_customer_id, new_start_station_id);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('New trip entry created successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Create or replace the procedure to show a customer their current trip
CREATE OR REPLACE PROCEDURE show_current_trip (
    customer_id IN trips.customers_customer_id%TYPE
)
AS
    v_trip_id trips.trip_id%TYPE;
    v_start_time trips.start_time%TYPE;
    v_end_time trips.end_time%TYPE;
    v_bike_id trips.bikes_bike_id%TYPE;
    v_start_station_id trips.start_station_id%TYPE;
    v_end_station_id trips.end_station_id%TYPE;
BEGIN
    SELECT trip_id, start_time, end_time, bikes_bike_id, start_station_id, end_station_id
    INTO v_trip_id, v_start_time, v_end_time, v_bike_id, v_start_station_id, v_end_station_id
    FROM trips
    WHERE customers_customer_id = customer_id
      AND end_time IS NULL; -- Retrieves only open trips

    -- Display the current trip details
    DBMS_OUTPUT.PUT_LINE('Current Trip Details:');
    DBMS_OUTPUT.PUT_LINE('Trip ID: ' || v_trip_id);
    DBMS_OUTPUT.PUT_LINE('Start Time: ' || TO_CHAR(v_start_time, 'DD-MON-YY'));
    DBMS_OUTPUT.PUT_LINE('End Time: ' || NVL(TO_CHAR(v_end_time, 'DD-MON-YY HH24:MI:SS'), 'Not ended yet'));
    DBMS_OUTPUT.PUT_LINE('Bike ID: ' || v_bike_id);
    DBMS_OUTPUT.PUT_LINE('Start Station ID: ' || v_start_station_id);
    DBMS_OUTPUT.PUT_LINE('End Station ID: ' || NVL(TO_CHAR(v_end_station_id), 'Not ended yet'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No open trip found for customer ' || customer_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END show_current_trip;
/

CREATE OR REPLACE PROCEDURE update_trip_end_details (
    customer_id_in IN trips.customers_customer_id%TYPE,
    end_station_id_in IN trips.end_station_id%TYPE
)
AS
    v_trip_id trips.trip_id%TYPE;
BEGIN
    -- Find the open trip for the specified customer
    SELECT trip_id
    INTO v_trip_id
    FROM trips
    WHERE customers_customer_id = customer_id_in
      AND end_time IS NULL; -- Assumes an open trip doesn't have an end time

    -- Update the end time and end station for the open trip
    UPDATE trips
    SET end_time = SYSDATE,
        end_station_id = end_station_id_in
    WHERE trip_id = v_trip_id;

    DBMS_OUTPUT.PUT_LINE('End time and station updated for trip ID ' || v_trip_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No open trip found for customer ' || customer_id_in);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END update_trip_end_details;
/

CREATE OR REPLACE FUNCTION calculate_rental_fee(
    trip_id_in IN trips.trip_id%TYPE
) RETURN NUMBER
AS
    start_time DATE;
    end_time DATE;
    fee_per_hour NUMBER := 10.0;  -- Assume a default fee or fetch dynamically as needed
    total_fee NUMBER;
    rental_duration_hrs NUMBER;
BEGIN
    -- Retrieve start and end times based on trip ID
    SELECT start_time, end_time
    INTO start_time, end_time
    FROM trips
    WHERE trip_id = trip_id_in;

    -- Ensure end_time is not null to proceed with duration calculation
    IF end_time IS NOT NULL THEN
        -- Calculate the duration in hours
        rental_duration_hrs := (end_time - start_time) * 24;
    ELSE
        -- If end_time is null, assume ongoing trip with no fees applicable yet
        rental_duration_hrs := 0;
    END IF;

    -- Calculate total fee
    total_fee := rental_duration_hrs * fee_per_hour;

    RETURN total_fee;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- If the trip information is not found, return zero as fee
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END;
/



CREATE OR REPLACE FUNCTION is_bike_available(
    bike_id_in IN bikes.bike_id%TYPE
) RETURN VARCHAR2
AS
    bike_status VARCHAR2(50);
BEGIN
    SELECT status INTO bike_status FROM bikes WHERE bike_id = bike_id_in;

    IF bike_status = 'Available' THEN
        RETURN 'Yes';
    ELSE
        RETURN 'No';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Bike not found';
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE FUNCTION get_customer_status(
    customer_id_in IN customers.customer_id%TYPE
) RETURN VARCHAR2
AS
    card_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO card_count FROM card WHERE customer_id = customer_id_in;

    IF card_count > 0 THEN
        RETURN 'Active';
    ELSE
        RETURN 'Inactive';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'No customer found';
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE FUNCTION total_trips_from_station(
    station_id_in IN stations.station_id%TYPE
) RETURN NUMBER
AS
    trips_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO trips_count FROM trips WHERE start_station_id = station_id_in;

    RETURN trips_count;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END;
/

--grant execute on procedures and functions
GRANT EXECUTE ON check_bike_availability_procedure TO system_admin, bike_user, maintenance_user;
GRANT EXECUTE ON create_new_customer TO system_admin, bike_user;
GRANT EXECUTE ON create_new_maintenance_procedure TO system_admin, maintenance_user;
GRANT EXECUTE ON fee_change_procedure TO system_admin;
GRANT EXECUTE ON new_trip TO system_admin, bike_user;
GRANT EXECUTE ON show_current_trip TO system_admin, bike_user;
GRANT EXECUTE ON update_end_of_maintenance TO system_admin, maintenance_user;
GRANT EXECUTE ON UPDATE_TRIP_END_DETAILS TO system_admin, bike_user;

GRANT EXECUTE ON calculate_rental_fee TO system_admin;
GRANT EXECUTE ON get_customer_status TO system_admin;
GRANT EXECUTE ON get_customer_status TO system_admin, bike_user ,maintenance_user;
GRANT EXECUTE ON total_trips_from_station TO system_admin, bike_user ,maintenance_user;

