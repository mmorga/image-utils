#!/usr/bin/env sh

# This script shows how to compare two images in four different ways with imagemagick

compare $1 $2 compare.png
compare $1 $2 -compose difference difference.png
convert $1 $2 -compose difference -composite -evaluate Pow 2 -separate -evaluate-sequence Add -evaluate Pow 0.5 enchanced-difference.png
convert -delay 20 $1 $2 -loop 0 flicker.gif
