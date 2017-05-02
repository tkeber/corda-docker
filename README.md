# corda-docker
Docker configuration and scripts for Corda

## Usage

example
```
docker build -t cordaDocker .
docker create --env CORDA_CITY=Wroclaw --env CORDA_LAGAL_NAME="Very important node" --name corda1 -t cordaDocker
docker start corda1
docker exec -t -i corda bash
```

### Node configuration


Docker environment variable | Corda configuration | default value 
--- | --- | ---
CORDA_HOST | part of p2pAddress |  localhost 
 CORDA_PORT | part of p2pAddress |10002 
 CORDA_CITY | nearestCity| London 
 CORDA_LEGAL_NAME | myLegalName| Corda Test Node 
 CORDA_EMAIL | emailAddress | admin@corda.test 
