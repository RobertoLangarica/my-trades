#!/bin/bash

if [ -n $DB_USERNAME ]; then

    # This command was designed to run inside a docker image from postgres as a step in initialization and as a docker exec for a postgress image
    
    # Avoiding race conditions when the servees is not initialized yet
    serverError=2 # 2 is the error returned when can't connect to the server
    while [ $serverError -eq 2 ]; do
    psql -v ON_ERROR_STOP=1 -q --username "$POSTGRES_USER"
    serverError=$?
    done

    psql -v ON_ERROR_STOP=1 -q --username "$POSTGRES_USER" <<-EOSQL 
    CREATE USER $DB_USERNAME WITH 
    PASSWORD '$DB_PASSWORD'
    CREATEDB 
    CREATEROLE;
EOSQL
    user=$?
    if [ -n $DB_DATABASE ]; then
        psql -v ON_ERROR_STOP=1 -q --username "$POSTGRES_USER" <<-EOSQL
        CREATE DATABASE $DB_DATABASE;
        GRANT ALL PRIVILEGES ON DATABASE $DB_DATABASE to $DB_USERNAME
EOSQL
    db=$?
    fi

    
    if [[ $user == 0  && $db == 0 ]]; then
    echo USING ROLE $DB_USERNAME
    echo USING DB $DB_DATABASE
    elif [[ $user == 3  && $db == 3 ]]; then
    echo USING ROLE $DB_USERNAME
    echo USING DB $DB_DATABASE
    else
    echo "A problem ocurred while trying to set the user an database"
    fi
fi
