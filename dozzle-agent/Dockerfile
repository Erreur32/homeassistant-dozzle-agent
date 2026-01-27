ARG BUILD_FROM
ARG DOZZLE_VERSION=9.0.3

# Stage 1: Get Dozzle binary from official image
FROM amir20/dozzle:v${DOZZLE_VERSION} AS dozzle_source

# Stage 2: Final image
FROM ${BUILD_FROM}

COPY config.yaml /tmp/config.yaml
COPY run.sh /

# Read version from config.yaml to verify, then copy binary
RUN DOZZLE_VERSION_CONFIG=$(awk -F': ' '/^dozzle.version:/ {print $2}' /tmp/config.yaml | tr -d '"' || echo "9.0.1") && \
    echo "Config version: ${DOZZLE_VERSION_CONFIG}, Build version: ${DOZZLE_VERSION}"

# Copy binary from Dozzle image (version from ARG)
COPY --from=dozzle_source /dozzle /usr/local/bin/dozzle

RUN chmod +x /usr/local/bin/dozzle && \
    chmod a+x /run.sh

CMD ["/run.sh"]
