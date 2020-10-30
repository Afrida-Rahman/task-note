#Production 
start:
	docker container start db notes-api
build:
	./boot.sh
stop:
	docker container stop notes-api db
destroy: stop
	docker network rm notes-api-network
	docker container rm notes-api db
	docker image rm notes-api

#Development
dev-start:
	docker-compose up --detach
dev-build:
	docker-compose up --detach --build;
dev-shell:
	docker-compose exec api bash
dev-stop:
	docker-compose stop
dev-destroy:
	docker-compose down --volume