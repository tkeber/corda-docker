#!/bin/bash

# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.

export CORDA_HOST="${CORDA_HOST-localhost}"
export CORDA_PORT="${CORDA_PORT-10002}"
export CORDA_CITY="${CORDA_CITY-London}"
export CORDA_LEGAL_NAME="${CORDA_LEGAL_NAME-Corda Test Node}"
export CORDA_EMAIL="${CORDA_EMAIL-admin@corda.test}"

cd /opt/corda

cat > node.conf << EOF
basedir : "/opt/corda"
artemisAddress : "$CORDA_HOST:$CORDA_PORT"
h2port : 11000
nearestCity : "$CORDA_CITY"
myLegalName : "$CORDA_LEGAL_NAME"
emailAddress : "$CORDA_EMAIL"
keyStorePassword : "cordacadevpass"
trustStorePassword : "trustpass"
extraAdvertisedServiceIds: [ "" ]
useHTTPS : false
devMode : true
rpcUsers=[
	{
		user=corda
		password=not_blockchain
		permissions=[
			StartFlow.net.corda.flows.CashIssueFlow,
			StartFlow.net.corda.flows.CashExitFlow,
			StartFlow.net.corda.flows.CashPaymentFlow
		]
	}
]
EOF

exec java -jar /opt/corda/corda.jar >>/opt/corda/logs/output.log 2>&1

