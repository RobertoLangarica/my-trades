#!/bin/bash
exist_credentilas=0
file=""

if [ -f .env ]; then
exist_credentilas=1
file=.env 
echo "Using: .env"
elif [ -f .env.example ]; then
file=.env.example
exist_credentilas=1
echo "Using: .env.example"
else
exist_credentilas=0
echo "No .env nor .env.example found, so the postgres server will be initialized with default credentials postgres|admin"
fi

user=""
db=""
if [ exist_credentilas ]; then
    POSTGRES_PASSWORD=$(grep DB_PASSWORD $file | cut -d "=" -f 2)
    POSTGRES_USER=$(grep DB_USERNAME $file | cut -d "=" -f 2)
    POSTGRES_DB=$(grep DB_DATABASE $file | cut -d "=" -f 2)
else
    POSTGRES_PASSWORD=admin
    POSTGRES_USER=postgres
    POSTGRES_DB=postgres
fi

# Data directory
LOCAL_DATA=~/nequ/database/postgresql/data
if ! [ -d $LOCAL_DATA ]; then
mkdir -p $LOCAL_DATA
echo "Creating the persistent directory for postgresSQL: "$LOCAL_DATA
fi


PGDATA=/var/lib/postgresql/data/pgdata
VOLUME=$LOCAL_DATA:/var/lib/postgresql/data

########
# When the DB is deployed in production the restart param should be --restart always
# When the DB is deployed locally the restart param could be --restart unless-stopped
########
docker run --name db_server -p 5432:5432 -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -e POSTGRES_USER=$POSTGRES_USER -e POSTGRES_DB=$POSTGRES_DB -e PGDATA=$POSTGRES_DB -v postgresData:/var/lib/postgresql/data --restart unless-stopped postgres:12
# To stop it run the next command: docker rm $(docker stop db_server)