#!/bin/sh

BOSUN=/opt/bosun/bin/bosun
CONFIG_FILE=/etc/bosun/bosun.conf
BOSUN_VERSION=$(${BOSUN} -version)

echo "Starting bosun ${BOSUN_VERSION}..."
${BOSUN} -c ${CONFIG_FILE} -t && ${BOSUN} -c ${CONFIG_FILE}

