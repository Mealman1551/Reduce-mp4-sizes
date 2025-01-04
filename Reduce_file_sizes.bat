@echo off
set /p input="Insert the path for the mp4: "
set /p output="Insert the output name for the output mp4 (without extension): "

ffmpeg -i "%input%" -vcodec libx264 -preset slow -crf 28 -acodec aac -strict experimental "%output%.mp4"

if %errorlevel% equ 0 (
    echo Conversion done! Output: %output%.mp4
) else (
    echo there is an error!
)
pause
