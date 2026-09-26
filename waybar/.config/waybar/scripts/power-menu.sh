#!/usr/bin/env bash
sel=$(printf '  Apagar\n  Reiniciar\n  Cerrar sesión' | wofi --dmenu --hide-search --lines 3 --width 220 --style ~/.config/waybar/scripts/power-menu.css)
case "$sel" in
  *Apagar*)          systemctl poweroff ;;
  *Reiniciar*)       systemctl reboot ;;
  *"Cerrar sesión"*) hyprctl dispatch exit ;;
esac
