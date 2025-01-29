@echo off
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must be run as administrator.
    echo Restart the command prompt as administrator and run this script again.
    pause
    exit /b
)

set "FFMPEG_PATH=C:\ffmpeg"

if exist "%FFMPEG_PATH%" (
    rmdir /s /q "%FFMPEG_PATH%"
    echo FFmpeg directory removed.
) else (
    echo FFmpeg directory not found.
)

for /f "tokens=1,* delims==" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path 2^>nul ^| findstr /I "Path"') do set "OLD_PATH=%%B"

echo %OLD_PATH% | findstr /I "%FFMPEG_PATH%\bin" >nul
if %errorLevel% == 0 (
    set "NEW_PATH=%OLD_PATH%"
    set "NEW_PATH=!NEW_PATH:%FFMPEG_PATH%\bin;=!"
    setx /M Path "!NEW_PATH!"
    echo FFmpeg removed from PATH.
) else (
    echo FFmpeg was not found in PATH.
)

pause
exit
