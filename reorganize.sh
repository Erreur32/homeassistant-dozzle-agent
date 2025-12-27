#!/bin/bash
# Script to reorganize the repository structure for Home Assistant add-on repository

set -e

echo "🔄 Reorganizing repository structure for Home Assistant..."

# Create the add-on directory
ADDON_DIR="dozzle-agent"
mkdir -p "$ADDON_DIR"

echo "📁 Created directory: $ADDON_DIR"

# Move add-on specific files to the directory
FILES_TO_MOVE=(
    "config.yaml"
    "Dockerfile"
    "run.sh"
    "translations"
    "icon.png"
    "logo.png"
    "apple-touch-icon.png"
    "CHANGELOG.md"
    "requirements.txt"
    "update_dozzle_version.sh"
)

for file in "${FILES_TO_MOVE[@]}"; do
    if [ -e "$file" ]; then
        echo "  📦 Moving $file → $ADDON_DIR/"
        mv "$file" "$ADDON_DIR/"
    else
        echo "  ⚠️  File $file not found, skipping..."
    fi
done

# Copy README.md to add-on directory (keep original at root)
if [ -f "README.md" ]; then
    echo "  📄 Copying README.md → $ADDON_DIR/"
    cp "README.md" "$ADDON_DIR/"
fi

echo ""
echo "✅ Repository reorganization complete!"
echo ""
echo "📋 Structure:"
echo "  homeassistant-dozzle-agent/"
echo "  ├── repository.json"
echo "  └── $ADDON_DIR/"
echo "      ├── config.yaml"
echo "      ├── Dockerfile"
echo "      └── ..."
echo ""
echo "⚠️  Next steps:"
echo "  1. Review the changes: git status"
echo "  2. Add the new structure: git add repository.json $ADDON_DIR/"
echo "  3. Commit: git commit -m 'chore: reorganize repository structure for Home Assistant'"
echo "  4. Push: git push origin main"
echo ""

