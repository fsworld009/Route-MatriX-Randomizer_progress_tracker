#!/bin/bash
set -e

# Create necessary files for local development

pushd "$(dirname "$0")" > /dev/null
version=${1:-"092"}

# Create data
node create_id_tables.js ../RouteMatriXRandomizer/$version/data ../src/$version/progress_tracker/data

# Create and patch boot.lua in modded_script
cd ..
cp RouteMatriXRandomizer/$version/data/multiworld/boot.lua src/$version/
patch -u src/$version/boot.lua src/$version/boot_lua.patch

popd > /dev/null
