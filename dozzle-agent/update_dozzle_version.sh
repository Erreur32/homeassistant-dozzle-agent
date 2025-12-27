#!/bin/bash
# Script to update Dozzle version in config.yaml and Dockerfile

if [ -z "$1" ]; then
    echo "Usage: ./update_dozzle_version.sh <version>"
    echo "Example: ./update_dozzle_version.sh 8.15.0"
    exit 1
fi

NEW_VERSION=$1

echo "Updating Dozzle version to ${NEW_VERSION}..."

# Update config.yaml
sed -i "s/dozzle.version: \".*\"/dozzle.version: \"${NEW_VERSION}\"/" config.yaml

# Update Dockerfile ARG default
sed -i "s/ARG DOZZLE_VERSION=.*/ARG DOZZLE_VERSION=${NEW_VERSION}/" Dockerfile

echo "✅ Updated to Dozzle version ${NEW_VERSION}"
echo ""
echo "Files updated:"
echo "  - config.yaml: dozzle.version: \"${NEW_VERSION}\""
echo "  - Dockerfile: ARG DOZZLE_VERSION=${NEW_VERSION}"
echo ""
echo "Next step: Rebuild the addon in Home Assistant"

