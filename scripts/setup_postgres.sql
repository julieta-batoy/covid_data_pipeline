-- Create the database
-- Replace 'database_name' with the actual database name (e.g., staging_covid_db)
CREATE DATABASE database_name;

-- Create the user (if not already existing)
-- Replace 'user' and 'password' with the actual user name (e.g., user123) and password (e.g., 'pass123')
CREATE USER user WITH PASSWORD 'password';

-- Grant all privileges to the user on the new database
-- Replace 'database_name' and 'user' with the actual database name (e.g., staging_covid_db) and (e.g., user123)
GRANT ALL PRIVILEGES ON DATABASE database_name TO user;
