#!/bin/bash
set -e

printf "creating network --->\n"
docker network create api-postgres-network;
printf "network created --->\n"

printf "\n"

printf "starting db container --->\n"
docker container run \
    --detach \
    --name=db \
    --env POSTGRES_PASSWORD=$DB_PASSWORD \
    --network=api-postgres-network \
    postgres
printf "db container started --->\n"

printf "\n"

printf "creating api image --->\n"
docker image build . --tag notes-api;
printf "api image created --->\n"
printf "starting api container --->\n"
docker container run \
    --detach \
    --name=notes-api \
    --env-file .env \
    --publish=3000:3000 \
    --network=api-postgres-network \
    notes-api;
printf "api container started --->\n"

docker container exec notes-api npm run db:migrate;

printf "\n"

printf "all containers are up and running"