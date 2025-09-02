#!/bin/bash
set -e

# Deploy the current modded boot.lua and progress_tracker in src
# This is for testing changes on an existing game, not for release or end-user installation
# Usage: bash test_deploy.sh path/to/game/folder/boot.lua 100
# Version is optional

pushd "$(dirname "$0")" > /dev/null
game_path=$1
version=${2:-"100"}

cp ../src/$version/boot.lua "$game_path/boot.lua"
rm -rf "$game_path/progress_tracker"
cp -r ../src/$version/progress_tracker "$game_path/progress_tracker"

popd > /dev/null
