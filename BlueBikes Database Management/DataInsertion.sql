
alter session disable parallel dml;


-- Insert station data
INSERT INTO STATIONS (name, location, capacity) VALUES ('Station A', 'Location A', 50);
INSERT INTO STATIONS (name, location, capacity) VALUES ('Station B', 'Location B', 75);
INSERT INTO STATIONS (name, location, capacity) VALUES ('Station C', 'Location C', 100);
INSERT INTO STATIONS (name, location, capacity) VALUES ('Station D', 'Location D', 20);
INSERT INTO STATIONS (name, location, capacity) VALUES ('Station E', 'Location E', 30);
COMMIT;

-- Insert bike data
INSERT INTO BIKES (model, status, location_id, purchase_date) VALUES ('Mountain', 'Available', 1, TO_DATE('2022-01-15', 'YYYY-MM-DD'));
INSERT INTO BIKES (model, status, location_id, purchase_date) VALUES ('Road', 'Available', 2, TO_DATE('2022-02-20', 'YYYY-MM-DD'));
INSERT INTO BIKES (model, status, location_id, purchase_date) VALUES ('Hybrid', 'In Use', 3, TO_DATE('2022-03-10', 'YYYY-MM-DD'));
INSERT INTO BIKES (model, status, location_id, purchase_date) VALUES ('Electric', 'Under Maintenance', 4, TO_DATE('2022-04-05', 'YYYY-MM-DD'));
COMMIT;

-- Insert customer data
INSERT INTO CUSTOMERS (first_name, last_name, email, phone) VALUES ('John', 'Mayer', 'john.mayer@example.com', '9876543210');
INSERT INTO CUSTOMERS (first_name, last_name, email, phone) VALUES ('Alice', 'Wright', 'alice.wright@example.com', '8765432109');
INSERT INTO CUSTOMERS (first_name, last_name, email, phone) VALUES ('Michael', 'Knight', 'michael.knight@example.com', '7654321098');
INSERT INTO CUSTOMERS (first_name, last_name, email, phone) VALUES ('Jessica', 'Stone', 'jessica.stone@example.com', '6543210987');
INSERT INTO CUSTOMERS (first_name, last_name, email, phone) VALUES ('Daniel', 'Storm', 'daniel.storm@example.com', '5432109876');
COMMIT;

-- Insert trip information
INSERT INTO TRIPS (start_time, end_time, bikes_bike_id, customers_customer_id, start_station_id, end_station_id, trip_paid)
VALUES (TO_DATE('2023-04-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-04-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 37, 1, 1, 2, 'Yes');
INSERT INTO TRIPS (start_time, end_time, bikes_bike_id, customers_customer_id, start_station_id, end_station_id, trip_paid)
VALUES (TO_DATE('2023-04-16 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-04-16 12:15:00', 'YYYY-MM-DD HH24:MI:SS'), 38, 3, 2, 3, 'No');
INSERT INTO TRIPS (start_time, end_time, bikes_bike_id, customers_customer_id, start_station_id, end_station_id, trip_paid)
VALUES (TO_DATE('2023-04-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-04-17 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 39, 23, 3, 4, 'Yes');
INSERT INTO TRIPS (start_time, end_time, bikes_bike_id, customers_customer_id, start_station_id, end_station_id, trip_paid)
VALUES (TO_DATE('2023-04-18 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-04-18 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 40, 24, 4, 5, 'No');
INSERT INTO TRIPS (start_time, end_time, bikes_bike_id, customers_customer_id, start_station_id, end_station_id, trip_paid)
VALUES (TO_DATE('2023-04-19 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-04-19 20:20:00', 'YYYY-MM-DD HH24:MI:SS'), 41, 25, 5, 1, 'Yes');
COMMIT;


-- Insert maintenance data
INSERT INTO MAINTENANCE (bike_id, start_of_maintenance, end_of_maintenance, description, maintenance_operator)
VALUES (37, TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-01-03', 'YYYY-MM-DD'), 'Routine check', 'Operator B');
INSERT INTO MAINTENANCE (bike_id, start_of_maintenance, end_of_maintenance, description, maintenance_operator)
VALUES (38, TO_DATE('2022-02-15', 'YYYY-MM-DD'), TO_DATE('2022-02-16', 'YYYY-MM-DD'), 'Battery replacement', 'Operator D');
INSERT INTO MAINTENANCE (bike_id, start_of_maintenance, end_of_maintenance, description, maintenance_operator)
VALUES (39, TO_DATE('2022-03-20', 'YYYY-MM-DD'), TO_DATE('2022-03-21', 'YYYY-MM-DD'), 'Brake adjustment', 'Operator A');
INSERT INTO MAINTENANCE (bike_id, start_of_maintenance, end_of_maintenance, description, maintenance_operator)
VALUES (40, TO_DATE('2022-04-10', 'YYYY-MM-DD'), TO_DATE('2022-04-12', 'YYYY-MM-DD'), 'Tire replacement', 'Operator D');
INSERT INTO MAINTENANCE (bike_id, start_of_maintenance, end_of_maintenance, description, maintenance_operator)
VALUES (41, TO_DATE('2022-05-05', 'YYYY-MM-DD'), TO_DATE('2022-05-07', 'YYYY-MM-DD'), 'Chain lubrication', 'Operator A');
COMMIT;


BEGIN
    INSERT INTO maintenance_log (maintenance_id, bike_id, log_time, description)
    VALUES (461, 37, TO_DATE('2025-12-31', 'YYYY-MM-DD'), 'Maintenance log entry 1');

    INSERT INTO maintenance_log (maintenance_id, bike_id, log_time, description)
    VALUES (462, 38, TO_DATE('2024-10-31', 'YYYY-MM-DD'), 'Maintenance log entry 2');

    INSERT INTO maintenance_log (maintenance_id, bike_id, log_time, description)
    VALUES (463, 39, TO_DATE('2026-06-30', 'YYYY-MM-DD'), 'Maintenance log entry 3');

    INSERT INTO maintenance_log (maintenance_id, bike_id, log_time, description)
    VALUES (464, 40, TO_DATE('2025-09-15', 'YYYY-MM-DD'), 'Maintenance log entry 4');

    INSERT INTO maintenance_log (maintenance_id, bike_id, log_time, description)
    VALUES (465, 41, TO_DATE('2023-04-28', 'YYYY-MM-DD'), 'Maintenance log entry 5');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully into MAINTENANCE_LOG table.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Rollback the transaction if an error occurs
        RAISE;
END;
/



--insert card data
INSERT INTO CARD (card_number, card_expiry, card_ssn, customer_id)
VALUES (1234567890123456, TO_DATE('2025-12-31', 'YYYY-MM-DD'), 1234, 1);

INSERT INTO CARD (card_number, card_expiry, card_ssn, customer_id)
VALUES (9876543210987654, TO_DATE('2024-10-31', 'YYYY-MM-DD'), 5678, 2);

INSERT INTO CARD (card_number, card_expiry, card_ssn, customer_id)
VALUES (1111222233334444, TO_DATE('2026-06-30', 'YYYY-MM-DD'), 9876, 3);

INSERT INTO CARD (card_number, card_expiry, card_ssn, customer_id)
VALUES (4444333322221111, TO_DATE('2025-09-15', 'YYYY-MM-DD'), 5432, 4);

INSERT INTO CARD (card_number, card_expiry, card_ssn, customer_id)
VALUES (5555666677778888, TO_DATE('2023-04-28', 'YYYY-MM-DD'), 8765, 5);

COMMIT;


--insert fee data
INSERT INTO FEES (fee_per_hour, date_of_implementation)
VALUES (10.50, TO_DATE('2022-01-01', 'YYYY-MM-DD'));

INSERT INTO FEES (fee_per_hour, date_of_implementation)
VALUES (8.75, TO_DATE('2022-02-15', 'YYYY-MM-DD'));

INSERT INTO FEES (fee_per_hour, date_of_implementation)
VALUES (15.00, TO_DATE('2022-03-20', 'YYYY-MM-DD'));

INSERT INTO FEES (fee_per_hour, date_of_implementation)
VALUES (5.25, TO_DATE('2022-04-10', 'YYYY-MM-DD'));

INSERT INTO FEES (fee_per_hour, date_of_implementation)
VALUES (12.00, TO_DATE('2022-05-05', 'YYYY-MM-DD'));

INSERT INTO FEES (fee_per_hour, date_of_implementation)
VALUES (9.99, TO_DATE('2022-06-08', 'YYYY-MM-DD'));

INSERT INTO FEES (fee_per_hour, date_of_implementation)
VALUES (20.50, TO_DATE('2022-07-15', 'YYYY-MM-DD'));

INSERT INTO FEES (fee_per_hour, date_of_implementation)
VALUES (7.75, TO_DATE('2022-08-20', 'YYYY-MM-DD'));

COMMIT;


INSERT INTO trip_fee_mapping (trip_id, fee_id)
VALUES (1, 1010);
INSERT INTO trip_fee_mapping (trip_id, fee_id)
VALUES (2, 1011);
INSERT INTO trip_fee_mapping (trip_id, fee_id)
VALUES (3, 1012); 
INSERT INTO trip_fee_mapping (trip_id, fee_id)
VALUES (4, 1013); 
INSERT INTO trip_fee_mapping (trip_id, fee_id)
VALUES (5, 1014); 

