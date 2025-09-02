# Route MatriX Randomizer progress tracker

## What is Route MatriX Randomizer

[Route MatriX Randomizer by Neoぼろくず工房](https://borokobo.web.fc2.com/index.html#RockC),
is a rom hack & lua script combination for randomizing original Rockman X games (X1~X3).

The games are randomized by distributing items and upgrades across 3 titles, so players will need
to swap between titles in order to complete the game.

## What is this repo (progress tracker) for?

Due to the natural of randomizing, title swapping, and high amount of collectable items,
it is easy to lose track of acquired items and game progress.

The game itself has UI to indicate missing items and game progress, but it could still be confusing
in some cases.

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

1. Create a Route MatriX Randomizer game, if you haven't:
   1. Download [Route MatriX Randomizer](https://borokobo.web.fc2.com/index.html#RockC)
   2. Open `RouteMatriXRandomizer.exe`, follow the instruction to create a randomized game
   3. The game will be created in a folder you specified in creator, with files like `boot.lua`,
      `boot.smc`, `lua`...etc
3. Download the Progress Tracker zip file from [Release page](./releases) and extract it.
4. For Windows users:
   1. Download [Patch for Windows](https://gnuwin32.sourceforge.net/packages/patch.htm) (Choose `Binaries`)
   2. Extract `patch.exe` to the folder where you extracted zip file.
      1. Make sure `RMR_progress_tracker_installer_win.bat` and `patch.exe` is in the same folder
   3. Run `RMR_progress_tracker_installer_win.bat`:
      1. Enter **Full Folder Path** of a generated RMR game, without `boot.lua` or `boot.smc` in the end (For example, `C:\games\Route MatriX Randomizer\20250902`)
      2. Wait for the installer to finish
      3. Run `boot.lua` in BizHawk like usual
4. For Linux users:
   1. Make sure `patch` is installed and is available in your `$PATH`
   2. Run `bash RMR_progress_tracker_installer_unix.sh`:
      1. Enter **Full Folder Path** of a generated RMR game, without `boot.lua` or `boot.smc` in the end (For example, `~/games/Route MatriX Randomizer/20250902`)
      2. Wait for the installer to finish
      3. Run `boot.lua` in BizHawk like usual

## Configuration

You can configure the Progress Tracker in `progress_tracker/config.ini`. All changes will not be
reflected until you close and reopen the boot.lua script in BizHawk.

Note to Value Type:
* Boolean Type: Possible value is `1` (enabled) and `0` (disabled)
* String Type: If it is for configuring file path, the path is relative to `boot.lua`

| Key | Value Type | Default | Purpose |
|----------|----------|----------|----------|
| item_log_enabled  | Boolean | 1 | If set to 1, output `item_log.txt`, which will be updated with Chinese readable text when acquiring new items in game. One item will occupy one row |
| item_log_path  | String  | item_log.txt  | Output file path for item_log
| item_id_log_enabled  | Boolean | 1 | If set to 1, output `item_id_log.txt`, which will be updated with Item ID when acquiring new items in game. One item will occupy one row |
| item_id_log_path  | String  | item_id_log.txt  | Output file path for item_id_log
| progress_report_enabled  | Boolean | 1 | If set to 1, output `progress_report_enabled.txt`, which contains a list of check IDs and item IDs and their current status |
| progress_report_path  | String  | progress_report.txt  | Output file path for progress_report

## Development

### Repository structure

This mod requires modifying the `boot.lua` script from the original project. To avoid sharing
that file directly in this repo, we only commit diff patch files for boot.lua.

The original project is versioned. To avoid potential compatibility issues breaking this
mod, the source code will also be split into different folders for each target version.

- `RouteMatriXRandomizer`: Original project, split by versions, for example, `RouteMatriXRandomizer/100` is the original project for Ver.100
- `src`: Source code, split by target versions, for example, `src/100` targets Ver.100 of the original project
- utils: Utility scripts

### Dependencies

* Unix environment (or Windows with wsl)
* Nodejs (v24 up)
* `diff` and `patch` command line tool

### Setup

1. Download the original project archive, and extract it under `RouteMatriXRandomizer/${Version}`.
   For example, `RouteMatriXRandomizer/100` (current version)
2. Run `utils/prepare_dev_env.sh`, this will generate boot.lua based on current patch
   and necessary data into `src/$version`. For example, `src/100/boot.lua` (current version)
   1. **Be careful to not run this script while you have local changes not updated**.
      This script will delete current local src/${Version}/boot.lua

### Test changes

Use `utils/test_deploy.sh` script to deploy changes to an existing game.

### Commit boot.lua changes

Use `utils/create_patch.sh` script to generate new patch and commit the updated patch.

### Create a release

Use `utils/create_release.sh` script to create a new release under `dist` folder, then manually
zip them and upload to GitHub release.
