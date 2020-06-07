#!/bin/bash

if [ -n $DB_USERNAME ]; then
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL 
        CREATE USER $DB_USERNAME WITH 
        PASSWORD '$DB_PASSWORD'
        CREATEDB 
        CREATEROLE;
EOSQL

    if [ -n $DB_DATABASE ]; then
        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
        CREATE DATABASE $DB_DATABASE;
        GRANT ALL PRIVILEGES ON DATABASE $DB_DATABASE to $DB_USERNAME
EOSQL
    fi

fi
