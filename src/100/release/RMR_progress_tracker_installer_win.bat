@echo off
setlocal enabledelayedexpansion

REM Change to script directory
cd /d "%~dp0"

echo Please enter full folder path to boot.lua (without "boot.lua")
set /p BOOT_SCRIPT_FOLDER_PATH=

echo Installing Progress Tracker to %BOOT_SCRIPT_FOLDER_PATH%:

if not exist "%BOOT_SCRIPT_FOLDER_PATH%" (
    echo Route MatriX Randomizer is not installed to %BOOT_SCRIPT_FOLDER_PATH%
    exit /b 1
)

if not exist "%BOOT_SCRIPT_FOLDER_PATH%\boot.lua" (
    echo Route MatriX Randomizer is not installed to %BOOT_SCRIPT_FOLDER_PATH%
    exit /b 1
)

if not exist "%BOOT_SCRIPT_FOLDER_PATH%\boot.smc" (
    echo Route MatriX Randomizer is not installed to %BOOT_SCRIPT_FOLDER_PATH%
    exit /b 1
)

if exist "%BOOT_SCRIPT_FOLDER_PATH%\progress_tracker" (
    echo Progress tracker is already installed!
    exit /b 1
)

patch.exe --binary -u "%BOOT_SCRIPT_FOLDER_PATH%\boot.lua" .\patches\boot_lua.patch

REM Copy progress_tracker directory recursively
xcopy /e /i progress_tracker "%BOOT_SCRIPT_FOLDER_PATH%\progress_tracker"

echo Done! Press any key to exit.

pause
