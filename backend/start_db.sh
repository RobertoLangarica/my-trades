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
fi

if [ exist_credentilas ]; then
    DB_PASSWORD=$(grep DB_PASSWORD $file | cut -d "=" -f 2)
    DB_USERNAME=$(grep DB_USERNAME $file | cut -d "=" -f 2)
    DB_DATABASE=$(grep DB_DATABASE $file | cut -d "=" -f 2)
fi

POSTGRES_PASSWORD=admin
POSTGRES_USER=postgres
POSTGRES_DB=postgres

# Data directory
PGDATA=/var/lib/postgresql/data/pgdata

########
# When the DB is deployed in production the restart param should be --restart always
# When the DB is deployed locally the restart param could be --restart unless-stopped
########
docker run --name db_server -p 5432:5432 -e DB_PASSWORD=$DB_PASSWORD -e DB_USERNAME=$DB_USERNAME -e DB_DATABASE=$DB_DATABASE -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -e POSTGRES_USER=$POSTGRES_USER -e POSTGRES_DB=$POSTGRES_DB -e PGDATA=$POSTGRES_DB -v postgresData:/var/lib/postgresql/data --restart unless-stopped langarica/postgres
# To stop it run the next command: docker rm $(docker stop db_server)