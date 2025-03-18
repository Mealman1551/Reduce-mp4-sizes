#!/bin/bash

read -p "Insert the path for the mp4: " input
read -p "Insert the output name for the output mp4 (without extension): " output

ffmpeg -i "$input" -vcodec libx264 -preset slow -crf 28 -acodec aac "${output}.mp4"

if [ $? -eq 0 ]; then
    echo "Conversion done! Output: ${output}.mp4"
else
    echo "there is an error!"
fi
