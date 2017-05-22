# corda-docker
Docker configuration and scripts to create a Corda image. This docker image base on [Phosion based image](https://github.com/phusion/baseimage-docker) - Docker optmise Ubuntu 16.04 LTS.


## Usage

* Check Dockerfile (e.g. to adjust version or Expose ports)
* Create base Corda image: `docker build -t corda:m11 .`
* Create configured container: `docker create --env CORDA_CITY=Wroclaw --env CORDA_COUNTRY=Poland --env CORDA_LEGAL_NAME="Very important node" --name corda11 -t corda:m11`
* Start container: `docker start corda11`
* Log into container: `docker exec -t -i corda11 bash`


## Node configuratio
Corda image can be 'personlize' with following environment variables as seen in an Usage example above. Table below list all avaliable variables as well it's default value.


### Environment Variables  

Docker environment variable | Corda configuration | default value 
--- | --- | ---
CORDA_HOST | hostname for Artemis |  localhost 
CORDA_PORT_P2P | P2P port |10002 
CORDA_PORT_RPC | RPC port |10003
CORDA_LEGAL_NAME | common name for myLegalName| Corda Test Node 
CORDA_ORG | organisation  for myLegalName | CordaTest
CORDA_ORG_UNIT | organizational unit for myLegalName | CordaTest
CORDA_COUNTRY | country for myLegalName | UK
CORDA_CITY | City for myLegalName and nearestCity | London 
CORDA_EMAIL | emailAddress | admin@corda.test 
