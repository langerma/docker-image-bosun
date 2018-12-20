#!/bin/bash

BOSUN=/opt/bosun/bin/bosun
CONFIG_FILE=/etc/bosun/bosun.conf
BOSUN_VERSION=$(${BOSUN} -version)

echo "Starting Bosun"
${BOSUN} -c ${CONFIG_FILE} -t && ${BOSUN} -c ${CONFIG_FILE}

