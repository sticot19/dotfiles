#!/bin/bash

WALLPAPERS_DIR="$HOME/Pictures/Wallpapers2025/"

# Lecture et sélection aléatoire en une étape
wallpaper=$(find "$WALLPAPERS_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | shuf -zn1 | tr -d '\0')

# Application avec swww
swww img "$wallpaper" --transition-type any --transition-fps 60 --transition-duration 2

# Application des couleurs avec matugen
matugen image "$wallpaper"
