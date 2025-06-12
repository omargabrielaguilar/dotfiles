#!/bin/bash

# Carpeta de wallpapers
WALL_DIR="$HOME/Pictures/wallpapers"

# Elige una imagen aleatoria (png o jpg)
WALL=$(find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n 1)

# Pon el wallpaper
feh --bg-scale "$WALL"

