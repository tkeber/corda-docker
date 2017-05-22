# corda-docker
Docker configuration and scripts for Corda

## Usage

example
```
docker build -t corda:m9 .
docker create --env CORDA_CITY=Wroclaw --env CORDA_LEGAL_NAME="Very important node" --name corda1 -t corda:m9
docker start corda1
docker exec -t -i corda1 bash
```

### Node configuration


Docker environment variable | Corda configuration | default value 
--- | --- | ---
CORDA_HOST | part of p2pAddress |  localhost 
 CORDA_PORT | part of p2pAddress |10002 
 CORDA_CITY | nearestCity| London 
 CORDA_LEGAL_NAME | myLegalName| Corda Test Node 
 CORDA_EMAIL | emailAddress | admin@corda.test 
