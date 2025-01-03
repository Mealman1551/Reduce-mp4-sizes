@echo off
set /p input="Geef het pad van de MP4-video: "
set /p output="Geef de naam voor het uitvoerbestand (zonder extensie): "

ffmpeg -i "%input%" -vcodec libx264 -preset slow -crf 28 -acodec aac -strict experimental "%output%.mp4"

if %errorlevel% equ 0 (
    echo Conversie voltooid! Uitvoerbestand: %output%.mp4
) else (
    echo Er is een fout opgetreden tijdens de conversie.
)
pause
