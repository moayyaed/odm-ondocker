#!/bin/bash

SDIR=$(dirname $0)

HOME_DIR=$(cd ${SDIR}/.. && pwd)


CERT_DIR="${HOME_DIR}/certs/kafka/"
ENV_FILE="${HOME_DIR}/.env"

source "${ENV_FILE}"
TRUSTOREPWD=$(cat ${CERT_DIR}/store-password.txt)
TMPFILE="/tmp/tmp.properties"
ODMTEMPLATEFILE="$HOME_DIR/odm/kafka_client_odm_template.properties"
ODMPROPERTIESFILE="$HOME_DIR/odm/kafka_client_odm.properties"
rm $ODMPROPERTIESFILE
sed -e "s|TRUESTOREPASSWORD|$TRUSTOREPWD|g" $ODMTEMPLATEFILE  > $TMPFILE ;  mv $TMPFILE $ODMPROPERTIESFILE
sed -e "s|KAFKAUSER|$KAFKA_USERNAME|g" $ODMPROPERTIESFILE   > $TMPFILE ;  mv $TMPFILE $ODMPROPERTIESFILE
sed -e "s|KAFKAPASSWORD|$KAFKA_PASSWORD|g" $ODMPROPERTIESFILE   > $TMPFILE ;  mv $TMPFILE $ODMPROPERTIESFILE
sed -e "s|KAFKAHOST|$KAFKA_EXTERNAL_HOSTNAME|g" $ODMPROPERTIESFILE   > $TMPFILE ;  mv $TMPFILE $ODMPROPERTIESFILE


docker-compose -f odm-standalone.yml up
