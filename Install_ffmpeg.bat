@echo off
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must be run as administrator.
    echo Restart the command prompt as administrator and run this script again.
    pause
    exit /b
)

set "FFMPEG_URL=https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full.7z"
set "FFMPEG_ARCHIVE=%TEMP%\ffmpeg.7z"
set "FFMPEG_PATH=C:\Windows"
set "SEVENZIP_EXE=C:\Program Files\7-Zip\7z.exe"
set "SEVENZIP_INSTALLER=%TEMP%\7zip.exe"
set "SEVENZIP_URL=https://www.7-zip.org/a/7z2301-x64.exe"

if not exist "%SEVENZIP_EXE%" (
    echo 7-Zip not found. Downloading and installing...
    powershell -Command "Invoke-WebRequest -Uri '%SEVENZIP_URL%' -OutFile '%SEVENZIP_INSTALLER%'"
    start /wait %SEVENZIP_INSTALLER% /S
)

echo Downloading FFmpeg...
powershell -Command "Invoke-WebRequest -Uri '%FFMPEG_URL%' -OutFile '%FFMPEG_ARCHIVE%'"

echo Extracting to %FFMPEG_PATH%...
"%SEVENZIP_EXE%" x "%FFMPEG_ARCHIVE%" -o"%FFMPEG_PATH%" -y >nul

for /d %%i in ("%FFMPEG_PATH%\ffmpeg-*") do (
    move /Y "%%i\bin\*" "%FFMPEG_PATH%" >nul
    rmdir /s /q "%%i"
)

echo Adding FFmpeg to PATH...
setx /M PATH "%PATH%;%FFMPEG_PATH%"

echo Verifying installation...
ffmpeg -version >nul 2>&1
if %errorLevel% == 0 (
    echo FFmpeg has been successfully installed in C:\Windows!
) else (
    echo Installation completed, but a restart may be required.
)

pause
exit
