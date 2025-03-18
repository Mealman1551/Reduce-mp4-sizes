@echo off
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must be run as administrator.
    echo Restart the command prompt as administrator and run this script again.
    pause
    exit /b
)

set "FFMPEG_PATH=C:\Windows"
set "FFMPEG_FILES=ffmpeg.exe ffplay.exe ffprobe.exe"

echo Removing FFmpeg files from %FFMPEG_PATH%...
for %%F in (%FFMPEG_FILES%) do (
    if exist "%FFMPEG_PATH%\%%F" (
        del /F /Q "%FFMPEG_PATH%\%%F"
        echo Deleted: %FFMPEG_PATH%\%%F
    ) else (
        echo Not found: %FFMPEG_PATH%\%%F
    )
)

for /f "tokens=1,* delims==" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path 2^>nul ^| findstr /I "Path"') do set "OLD_PATH=%%B"

echo %OLD_PATH% | findstr /I "%FFMPEG_PATH%" >nul
if %errorLevel% == 0 (
    set "NEW_PATH=%OLD_PATH%"
    set "NEW_PATH=!NEW_PATH:%FFMPEG_PATH%;=!"
    setx /M Path "!NEW_PATH!"
    echo FFmpeg removed from PATH.
) else (
    echo FFmpeg was not found in PATH.
)

pause
exit
