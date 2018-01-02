# corda-docker
Docker configuration and files to create and spin up Docker images for Corda Node and Networkmap. The docker image is based on Alpine/OpenJDK (https://hub.docker.com/_/openjdk/)

## Usage (automatic way - using docker compose)

* Check Dockerfile and docker-compose.yml (e.g. to adjust version or exposed ports)
* `docker-compose build` - to create base Corda images for Corda Node and Networkmap
* `docker-compose up` - to spin up both Corda containers (Node + Networkmap)
* `docker exec -it node /bin/sh` - to log in to the running Node container
* `docker exec -it networkmap /bin/sh` - to log in to the running Networkmap container

## Corda configuration
If you need to modify Corda parameters (node or/and networkmap) change their configuration file(s) and restart container:
### For Corda node:
* modify `files/corda-node.conf`
* restart Corda node: `docker restart node`
### For Networkmap node:
* modify `files/corda-networkmap.conf`
* restart Corda networkmap: `docker restart networkmap`
