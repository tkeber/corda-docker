#!/bin/sh

export JAVA_OPTIONS="${JAVA_OPTIONS--Xmx512m}"
export CORDA_HOME=/opt/corda

cd ${CORDA_HOME}
java $JAVA_OPTIONS -jar ${CORDA_HOME}/corda-webserver.jar 2>&1 &
java $JAVA_OPTIONS -jar ${CORDA_HOME}/corda.jar 2>&1
