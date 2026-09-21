#!/usr/bin/env bash

set -euo pipefail

# Include Python user-installed commands such as ctgen
export PATH="$HOME/.local/bin:$PATH"

if ! command -v ctgen >/dev/null 2>&1; then
    echo "Error: ctgen was not found."
    echo 'Install it with: python3 -m pip install --user "clickgen>=2.1.8"'
    exit 1
fi

THEME_NAME="Bibata-Modern-Amber-192"
BITMAP_DIR="bitmaps/$THEME_NAME"

echo "========================================"
echo " Building $THEME_NAME"
echo "========================================"

echo "[1/3] Cleaning old build..."
rm -rf "$BITMAP_DIR"
rm -rf "themes/$THEME_NAME"

echo "[2/3] Rendering Bibata Modern Amber..."
npx cbmp \
  -d "svg/modern" \
  -o "$BITMAP_DIR" \
  -bc "#FF8300" \
  -oc "#FFFFFF" \
  -wc "#001524"

echo "[3/3] Building native 192px XCursor..."
ctgen configs/normal/x.build.toml \
  -s 192 \
  -p x11 \
  -d "$BITMAP_DIR" \
  -n "$THEME_NAME" \
  -c "192px Bibata Modern Amber XCursor"

echo
echo "========================================"
echo " Build completed!"
echo " Theme: themes/$THEME_NAME"
echo "========================================"
