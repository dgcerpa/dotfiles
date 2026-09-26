#!/usr/bin/env bash
# Elige un wallpaper al azar, escribe hyprpaper.conf y lanza el daemon.

DIR="$HOME/Imágenes/Wallpapers"
CONF="$HOME/.config/hypr/hyprpaper.conf"

WALL=$(find "$DIR" -maxdepth 1 -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | shuf -n 1)

[ -z "$WALL" ] && exit 1

cat > "$CONF" <<CONFEOF
# Generado por random-wallpaper.sh — no editar a mano
wallpaper {
  monitor =
  path = $WALL
  fit_mode = cover
}
CONFEOF

pkill hyprpaper
sleep 0.5
exec hyprpaper
