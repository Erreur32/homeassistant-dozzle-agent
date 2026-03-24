#!/usr/bin/with-contenv bashio

LOG_LEVEL="$(bashio::config 'log_level')"
HOSTNAME="$(bashio::config 'hostname')"

if [ -z "$LOG_LEVEL" ]; then
    LOG_LEVEL="info"
fi

# ─────────────────────────────────────────────
#  START — $(date '+%Y-%m-%d %H:%M:%S')
# ─────────────────────────────────────────────
bashio::log.info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bashio::log.info " Dozzle Agent — démarrage"
bashio::log.info " Date    : $(date '+%Y-%m-%d %H:%M:%S')"
bashio::log.info " Version : $(bashio::addon.version)"
bashio::log.info " Log lvl : ${LOG_LEVEL}"

export DOZZLE_LEVEL="${LOG_LEVEL}"

if [ -n "$HOSTNAME" ]; then
    export DOZZLE_HOSTNAME="${HOSTNAME}"
    bashio::log.info " Hostname: ${HOSTNAME}"
fi

bashio::log.info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

/usr/local/bin/dozzle agent --addr 0.0.0.0:7007 --level "${LOG_LEVEL}"
