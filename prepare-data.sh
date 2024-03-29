#!/usr/bin/env bash

export PGPASSWORD=postgres

## Create table in the 'metadata' database
#psql -h localhost -p 5432 -U postgres -d metadata -c '
#CREATE TABLE customers (
#    name VARCHAR(255),
#    age INT
#);' || { echo "Failed to create table in metadata database"; exit 1; }
#
## Create table in the 'data_1' database
#psql -h localhost -p 5433 -U postgres -d data_1 -c '
#CREATE TABLE customers (
#    name VARCHAR(255),
#    age INT
#);' || { echo "Failed to create table in data_1 database"; exit 1; }
#
## Insert data into the 'data_1' database
#psql -h localhost -p 5433 -U postgres -d data_1 -c "
#INSERT INTO customers (name, age) VALUES
#  ('customer1', 20),
#  ('customer2', 40),
#  ('customer3', 75);" || { echo "Failed to insert data into data_1 database"; exit 1; }
#
## Create table in the 'data_2' database
#psql -h localhost -p 5434 -U postgres -d data_2 -c '
#CREATE TABLE customers (
#    name VARCHAR(255),
#    age INT
#);' || { echo "Failed to create table in data_2 database"; exit 1; }

# Create table in ClickHouse
docker compose exec clickhouse clickhouse-client --multiquery -q "
CREATE USER admin HOST ANY IDENTIFIED WITH plaintext_password by 'admin';

create table wikistat (
    project String,
    subproject String,
    hits UInt64,
    size UInt64
) ENGINE = Memory;

insert into wikistat values ('from clickouse', 'good', 1, 2);

GRANT SELECT ON wikistat TO admin;

"

psql -p 9005 - h localhost -U admin default

echo "Script executed successfully."