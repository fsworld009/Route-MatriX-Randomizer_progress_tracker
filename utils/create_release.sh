#!/bin/bash
set -e

# Script to create a release

# Create a public release
# It is expected to create versions in format of v{game_version}-{date}{-optional-patch}
# For example: v100-20250902, v100-20250902-2

# Game version is optional

release_version=${1:""}

if [ -z "$release_version" ]; then
  echo "Error: Release version is not provided"
  exit 1
fi

game_version=${2:-"100"}

pushd "$(dirname "$0")" > /dev/null
cd ..

# Reset all local changes, make sure files are generated from code
cd utils
bash prepare_dev_env.sh $game_version
cd ..

# Create folders
mkdir -p dist
rm -rf dist/$release_version
mkdir -p dist/$release_version
mkdir -p dist/$release_version/patches

# Copy installer and patch
cp src/$game_version/release/*.sh dist/$release_version
cp src/$game_version/release/*.bat dist/$release_version
cp src/$game_version/*.patch dist/$release_version/patches
cp -r src/$game_version/progress_tracker dist/$release_version/progress_tracker

echo "Release dist/$release_version is created."

popd > /dev/null
