#!/bin/bash

#export USER=`whoami`
export BASE_DIR=$PWD
export ADMIN_DIR=/data/admin/wmagent
#export CERT_DIR=$BASE_DIR/certs
export MDB_UNITTEST_DB=${MDB_UNITTEST_DB}

export PYTHONPATH=$BASE_DIR/test/python:$PYTHONPATH
export PYTHONPATH=$BASE_DIR/src/python:$PYTHONPATH

export DATABASE=mysql://${MDB_USER}:${MDB_PASS}@127.0.0.1/${MDB_UNITTEST_DB}
export COUCHURL=http://unittestagent:passwd@localhost:${COUCH_PORT}
export DIALECT=MySQL

export WMAGENT_SECRETS_LOCATION=$ADMIN_DIR/WMAgent.secrets
#export X509_HOST_CERT=$CERT_DIR/usercert.pem
#export X509_HOST_KEY=$CERT_DIR/userkey_nopwd.pem
#export X509_USER_CERT=$CERT_DIR/usercert.pem
#export X509_USER_KEY=$CERT_DIR/userkey_nopwd.pem

### some Rucio setup needed for jenkins and docker unit tests
# fetch the values defined in the secrets file and update rucio.cfg file
export RUCIO_HOME=$PWD/.devcontainer # TODO: Change to specific rucio directory
MATCH_RUCIO_HOST=`cat $WMAGENT_SECRETS_LOCATION | grep RUCIO_HOST | sed s/RUCIO_HOST=//`
MATCH_RUCIO_AUTH=`cat $WMAGENT_SECRETS_LOCATION | grep RUCIO_AUTH | sed s/RUCIO_AUTH=//`
sed "s+^rucio_host.*+rucio_host = $MATCH_RUCIO_HOST+" $RUCIO_HOME/etc/rucio.cfg-temp > $RUCIO_HOME/etc/rucio.cfg
sed "s+^auth_host.*+auth_host = $MATCH_RUCIO_AUTH+" $RUCIO_HOME/etc/rucio.cfg-temp > $RUCIO_HOME/etc/rucio.cfg
echo "Updated RUCIO_HOME file under: $RUCIO_HOME"
