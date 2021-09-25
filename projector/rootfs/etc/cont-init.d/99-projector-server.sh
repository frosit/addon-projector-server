#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Projector
# Sets up code-server.
# ==============================================================================

bashio::log.info "Starting Projector configuration..."

# Create main config
PROJECTOR_CONFIG_DIRECTORY=$(bashio::config 'config_path')
PROJECTOR_APP=$(bashio::config 'app')
PROJECTOR_CONFIG_NAME=$(bashio::config 'config_name')
PROJECTOR_HOST=$(bashio::config 'host')
PROJECTOR_PORT=$(bashio::addon.ingress_port)

PROJECTOR_DEFAULTS_INI="${PROJECTOR_CONFIG_DIRECTORY}/.defaults.ini"
PROJECTOR_APP_CONFIG_DIRECTORY="${PROJECTOR_CONFIG_DIRECTORY}/configs/${PROJECTOR_CONFIG_NAME}"
PROJECTOR_APP_CONFIG_INI="${PROJECTOR_APP_CONFIG_DIRECTORY}/config.ini"

# @todo make configurable
export ORG_JETBRAINS_PROJECTOR_SERVER_HOST="${PROJECTOR_HOST}"
export ORG_JETBRAINS_PROJECTOR_SERVER_PORT="${PROJECTOR_PORT}"

bashio::log.debug "config path: ${PROJECTOR_CONFIG_DIRECTORY}"
bashio::log.debug "app: ${PROJECTOR_APP}"
bashio::log.debug "app config dir: ${PROJECTOR_APP_CONFIG_DIRECTORY}"
bashio::log.debug "app config ini: ${PROJECTOR_APP_CONFIG_INI}"
bashio::log.debug "config name: ${PROJECTOR_CONFIG_NAME}"

# Ensure persistent data folder exists.
if ! bashio::fs.directory_exists "${PROJECTOR_CONFIG_DIRECTORY}"; then
    bashio::log.debug "config directory ${PROJECTOR_CONFIG_DIRECTORY} does not exist, creating..."
    mkdir -p "${PROJECTOR_CONFIG_DIRECTORY}/configs" \
        || bashio::exit.nok "Could not create projector storage folder."
else
    bashio::log.debug "config directory found at ${PROJECTOR_CONFIG_DIRECTORY}"
fi

# ensure defaults ini
if ! bashio::fs.file_exists "${PROJECTOR_DEFAULTS_INI}"; then
    bashio::log.debug "default config file not found at ${PROJECTOR_DEFAULTS_INI}, creating..."
    touch "${PROJECTOR_DEFAULTS_INI}" \
        || bashio::exit.nok 'Failed to create .defaults.ini'
{
    echo "[PROJECTOR]";
    echo "port = ${PROJECTOR_PORT}";
    echo "host = ${PROJECTOR_HOST}";
    echo "";
    echo "[FQDNS]";
    echo "fqdns = *";
    echo "";
    echo "[CHANNEL]";
    echo "channel = tested";
} > "${PROJECTOR_DEFAULTS_INI}"
fi

# install app
if ! bashio::fs.directory_exists "${PROJECTOR_APP_CONFIG_DIRECTORY}"; then

    bashio::log.debug "app config directory not found at ${PROJECTOR_APP_CONFIG_DIRECTORY}, starting installation..."

    projector --accept-license --config-directory "${PROJECTOR_CONFIG_DIRECTORY}" \
	ide autoinstall \
	--config-name="${PROJECTOR_CONFIG_NAME}" \
	--ide-name="${PROJECTOR_APP}" \
	--hostname="${PROJECTOR_HOST}" \
	--port="${PROJECTOR_PORT}"
else
    bashio::log.info "app exists at ${PROJECTOR_APP_CONFIG_DIRECTORY}"
fi

