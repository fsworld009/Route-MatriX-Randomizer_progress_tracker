#!/bin/bash
set -e

# Create patch file for boot.lua
# Usage: bash create_patch.sh
# To specify a version: bash create_patch.sh 092

pushd "$(dirname "$0")" > /dev/null
version=${1:-"092"}

cd ..
diff -u RouteMatriXRandomizer/$version/data/multiworld/boot.lua src/$version/boot.lua > src/$version/boot_lua.patch
popd > /dev/null
