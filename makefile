default: build
	docker-compose up -d --remove-orphans
up:
	docker-compose up --remove-orphans
down:
	docker-compose down --remove-orphans

build:
	docker-compose build

stop: down
start: up
restart: down default

clean-docker:
	docker volume prune
	docker image prune

fix-perms:
	sudo chown ${UID}:${UID} ./* -R
	sudo chown ${UID}:${UID} ./.* -R