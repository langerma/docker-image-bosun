#!/bin/sh

BOSUN=/opt/bosun/bin/bosun
CONFIG_FILE=/etc/bosun/bosun.conf
BOSUN_VERSION=$(${BOSUN} -version)

echo "Starting bosun version 0.8.0-dev last modified 2019-02-15T10:25:34+01:00"
${BOSUN} -c ${CONFIG_FILE} -t && ${BOSUN} -c ${CONFIG_FILE}

