-- System Admin User Creation and Setup
BEGIN
    EXECUTE IMMEDIATE 'CREATE USER system_admin IDENTIFIED BY BostonSpring2024#';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01920 THEN 
            DBMS_OUTPUT.PUT_LINE('Error: User already exists.');
        ELSE
            RAISE;
        END IF;
END;
/

-- Grants for System Admin
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE, CREATE TRIGGER, CREATE USER TO system_admin;
ALTER USER system_admin QUOTA Unlimited ON USERS;


-- Create users

BEGIN
    EXECUTE IMMEDIATE 'CREATE USER bike_user IDENTIFIED BY BostonSpring2024#';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01920 THEN
            DBMS_OUTPUT.PUT_LINE('Error: User already exists.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE USER maintenance_user IDENTIFIED BY NEUSpring2024';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -01920 THEN
            DBMS_OUTPUT.PUT_LINE('Error: User already exists.');
        ELSE
            RAISE;
        END IF;
END;
/

-- Grant necessary privileges to users
GRANT CREATE SESSION TO maintenance_user, bike_user;
ALTER USER maintenance_user QUOTA 100M ON USERS;
ALTER USER bike_user QUOTA 100M ON USERS;