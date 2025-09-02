#!/bin/bash
set -e
pushd "$(dirname "$0")" > /dev/null

echo "Please enter full folder path to boot.lua (without \"boot.lua\")"
read BOOT_SCRIPT_FOLDER_PATH

echo "Installing Progress Tracker to $BOOT_SCRIPT_FOLDER_PATH:"

if [ ! -d "$BOOT_SCRIPT_FOLDER_PATH" ] || [ ! -f "$BOOT_SCRIPT_FOLDER_PATH/boot.lua" ] ||  [ ! -f "$BOOT_SCRIPT_FOLDER_PATH/boot.smc" ]; then
  echo "Route MatriX Randomizer is not installed to $BOOT_SCRIPT_FOLDER_PATH"
  exit 1
fi

if [ -d "$BOOT_SCRIPT_FOLDER_PATH/progress_tracker" ]; then
  echo "Progress tracker is already installed!"
  exit 1
fi

patch -u "$BOOT_SCRIPT_FOLDER_PATH/boot.lua" ./patches/boot_lua.patch
cp -vr progress_tracker "$BOOT_SCRIPT_FOLDER_PATH"

echo "Done! Press Enter to exit."
read

popd > /dev/null
