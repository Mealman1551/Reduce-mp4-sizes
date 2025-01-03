#!/bin/bash

read -p "Geef het pad van de MP4-video: " input
read -p "Geef de naam voor het uitvoerbestand (zonder extensie): " output

ffmpeg -i "$input" -vcodec libx264 -preset slow -crf 28 -acodec aac "${output}.mp4"

if [ $? -eq 0 ]; then
    echo "Conversie voltooid! Uitvoerbestand: ${output}.mp4"
else
    echo "Er is een fout opgetreden tijdens de conversie."
fi
