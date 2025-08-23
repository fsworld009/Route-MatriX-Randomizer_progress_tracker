# Route MatriX Randomizer progress tracker

## What is this

[Route MatriX Randomizer by Neoぼろくず工房](https://borokobo.web.fc2.com/index.html#RockC),
is a rom hack & lua script combination for randomizing original Rockman X games (X1~X3).

Due to the natural of randomizing and high amount of collectable items, it is easy to lose
track of acquired items and game progress. The game itself has UI to indicate missing
items and game progress, but it could still be confusing in some cases.

This project is a mod for the lua script to help the player tracking the current game progress
better:

1. When acquiring items, the acquired item name will be output to a text log file.
2. When acquiring items, the acquired item ID will be output to a separate ID log file.
3. A game progress report file will be created to list current acquired items and game progress,
   and will be updated on time when acquiring new items or having any progress in game (e.g. beat a stage)

All features can be toggled and the output file paths can be configured.

The ID Log and Progress report might not be easy to read on its own, but they can be consumed by
other GUI programs to provide even better user experience.

## Installation

TBD

## Configuration

TBD

## Development

### Repository structure

This mod requires modifying the `boot.lua` script from the original project. To avoid sharing
that file directly in this repo, we only commit diff patch files for boot.lua.

The original project is versioned. To avoid potential compatibility issues breaking this
mod, the source code will also be split into different folders for each target version.

- `RouteMatriXRandomizer`: Original project, split by versions, for example, `RouteMatriXRandomizer/092` is the original project for Ver.092
- `src`: Source code, split by target versions, for example, `src/092` targets Ver.092 of the original project
- utils: Utility scripts

### Dependencies

* Unix environment
* Nodejs (v24 up)
* `diff` and `patch` command line tool

### Setup

1. Download the original project archive, and extract it under `RouteMatriXRandomizer/${Version}`.
   For example, `RouteMatriXRandomizer/092` (current version)
2. Run `utils/prepare_dev_env.sh`, this will generate boot.lua based on current patch
   and necessary data into `src/$version`. For example, `src/092/boot.lua` (current version)
   1. **Be careful to not run this script while you have local changes not updated**.
      This script will delete current local src/${Version}/boot.lua

### Test changes

Use `utils/test_deploy.sh` script to deploy changes to an existing game.

### Commit boot.lua changes

Use `utils/create_patch.sh` script to generate new patch and commit the updated patch.
