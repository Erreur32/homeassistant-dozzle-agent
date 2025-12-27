#!/usr/bin/with-contenv bashio

LOG_LEVEL="$(bashio::config 'log_level')"
HOSTNAME="$(bashio::config 'hostname')"

if [ -z "$LOG_LEVEL" ]; then
    LOG_LEVEL="info"
fi

export DOZZLE_LEVEL="${LOG_LEVEL}"

if [ -n "$HOSTNAME" ]; then
    export DOZZLE_HOSTNAME="${HOSTNAME}"
fi

/usr/local/bin/dozzle agent --addr 0.0.0.0:7007 --level "${LOG_LEVEL}"
