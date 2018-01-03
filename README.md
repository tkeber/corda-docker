# corda-docker
Docker configuration and files to create and spin up Docker images for two Corda Nodes (banka + bankb), Networkmap and Notary.
The docker image is based on Alpine/OpenJDK (https://hub.docker.com/_/openjdk/)

## Usage (automatic way - using docker compose)

* Check Dockerfile and docker-compose.yml (e.g. to adjust version or exposed ports)
* `docker-compose build` - to create base Corda images for Corda Node/Networkmap/Notary
* `docker-compose up` - to spin up all Corda containers (Node1 + Node2 + Networkmap + Notary)
* `docker exec -it banka /bin/sh` - to log in to one of the running Node containers
* `docker exec -it networkmap /bin/sh` - to log in to the running Networkmap container

## Corda configuration
If you need to modify Corda parameters (node or/and networkmap) change their configuration file(s) and restart container:
### For Corda node (i.e. banka):
* modify `files/corda-banka.conf`
* restart Corda node: `docker restart banka`
### For Networkmap node:
* modify `files/corda-networkmap.conf`
* restart Corda networkmap: `docker restart networkmap`

## TODO
* add more to README.md (how to customise the build, potential manual spin up without docker compose) 
* spin up additional Corda node to test communication/CordApps between nodes
* add notary node
* let customise java options
* add webserver
* add example CordApp(s)
