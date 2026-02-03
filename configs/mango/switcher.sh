#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"

menu() {
    find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | while read -r file; do
        echo "$(basename "$file")"
    done
}
main() {
    choice=$(menu | fuzzel -d "Select Wallpaper:")

    if [ -n "$choice" ]; then
        wallpaper=$(find "${WALLPAPER_DIR}" -name "$choice" | head -1)
        awww img "$wallpaper" \
            --transition-type any \
            --transition-fps 60 \
            --transition-duration .5
    fi
}
main
