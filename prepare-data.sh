#!/usr/bin/env bash

export PGPASSWORD=postgres

# Create table in the 'metadata' database
psql -h localhost -p 5432 -U postgres -d metadata -c '
CREATE TABLE customers (
    name VARCHAR(255),
    age INT
);' || { echo "Failed to create table in metadata database"; exit 1; }

# Create table in the 'data_1' database
psql -h localhost -p 5433 -U postgres -d data_1 -c '
CREATE TABLE customers (
    name VARCHAR(255),
    age INT
);' || { echo "Failed to create table in data_1 database"; exit 1; }

# Insert data into the 'data_1' database
psql -h localhost -p 5433 -U postgres -d data_1 -c "
INSERT INTO customers (name, age) VALUES
  ('customer1', 20),
  ('customer2', 40),
  ('customer3', 75);" || { echo "Failed to insert data into data_1 database"; exit 1; }

# Create table in the 'data_2' database
psql -h localhost -p 5434 -U postgres -d data_2 -c '
CREATE TABLE customers (
    name VARCHAR(255),
    age INT
);' || { echo "Failed to create table in data_2 database"; exit 1; }

echo "Script executed successfully."