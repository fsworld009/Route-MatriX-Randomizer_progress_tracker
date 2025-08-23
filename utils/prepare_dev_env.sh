#!/bin/bash
set -e

# Create necessary files for local development


version="092"
version=${1:-"092"}

# Create data
node create_id_tables.js ../RouteMatriXRandomizer/$version/data ../src/$version/progress_tracker/data

# Create and patch boot.lua in modded_script
cd ..
cp RouteMatriXRandomizer/$version/data/multiworld/boot.lua src/$version/
patch -p0 < src/$version/boot_lua.patch

popd > /dev/null
