-- ═══════════════════════════════════════════════════════════
-- HYPRLAND · Config Lua (migrado desde hyprland.conf)
-- Hyprland 0.56.2 · 25 sep 2026
-- ═══════════════════════════════════════════════════════════

---- MONITORES ----
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

---- PROGRAMAS ----
local mod         = "SUPER"
local terminal    = "kitty"
local fileManager = "thunar"

---- AUTOSTART ----
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("sh -c 'sleep 2; systemctl --user reset-failed xdg-desktop-portal-hyprland; systemctl --user restart xdg-desktop-portal-hyprland'")
    hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
    hl.exec_cmd("sh -c 'waybar >> ~/.cache/waybar.log 2>&1'")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("~/.config/hypr/scripts/random-wallpaper.sh")
    -- gnome-keyring lo arranca PAM al login; la linea del .conf era redundante
end)

---- ENTORNO ----
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

---- ASPECTO ----
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = { colors = {"rgba(3b82f6ff)", "rgba(38bdf8ff)"}, angle = 45 },
            inactive_border = "rgba(0a1430aa)",
        },
        layout = "dwindle",
    },
    decoration = {
        rounding = 8,
        blur = {
            enabled = true,
            size = 6,
            passes = 1,
            new_optimizations = true,
            noise = 0.015,
            contrast = 1.0,
            brightness = 1.0,
        },
    },
    animations = { enabled = true },
    dwindle = { preserve_split = true },
    input = {
        kb_layout = "latam",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
        },
    },
})

---- CURVAS ----
hl.curve("overshoot", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.3} } })
hl.curve("cinematic", { type = "bezier", points = { {0.25, 0.1}, {0.25, 1.0} } })
hl.curve("snappy",    { type = "bezier", points = { {0.4,  0.0}, {0.2, 1.0} } })
hl.curve("smooth",    { type = "bezier", points = { {0.4,  0.0}, {0.6, 1.0} } })

---- ANIMACIONES ----
hl.animation({ leaf = "windows",     enabled = true, speed = 3, bezier = "overshoot", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3, bezier = "cinematic", style = "popin 80%" })
hl.animation({ leaf = "fade",        enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2, bezier = "snappy" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 3, bezier = "cinematic", style = "slide" })
hl.animation({ leaf = "border",      enabled = true, speed = 2, bezier = "smooth" })

---- APPS Y SESION ----
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("wofi --show drun"))
hl.bind("ESCAPE", hl.dsp.exec_cmd("pkill wofi"))
hl.bind(mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + X", hl.dsp.window.close())
hl.bind(mod .. " + M", hl.dsp.exit())
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())

---- ATAJOS A APPS ----
hl.bind(mod .. " + Z", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("claude-desktop"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd("rstudio"))
hl.bind(mod .. " + S", hl.dsp.exec_cmd("spotify"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("code"))
hl.bind(mod .. " + A", hl.dsp.exec_cmd("obsidian"))
hl.bind(mod .. " + G", hl.dsp.exec_cmd("github-desktop"))
hl.bind(mod .. " + W", hl.dsp.exec_cmd("jlab"))

---- FOCO Y MOVIMIENTO ----
for _, d in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(mod .. " + " .. d, hl.dsp.focus({ direction = d }))
    hl.bind(mod .. " + SHIFT + " .. d, hl.dsp.window.move({ direction = d }))
end

---- WORKSPACES ----
for i = 1, 9 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

---- MOUSE ----
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

---- AUDIO (F1/F2/F3 por Fn Lock invertido) ----
hl.bind("F1", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("F2", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("F3", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true })

---- BRILLO ----
hl.bind("F6", hl.dsp.exec_cmd("brightnessctl --device 'amdgpu_bl1' set +10%"), { locked = true, repeating = true })
hl.bind("F5", hl.dsp.exec_cmd("brightnessctl --device 'amdgpu_bl1' set 10%-"), { locked = true, repeating = true })

---- LUZ DEL TECLADO (cicla 0 -> 1 -> 2 -> 0) ----
hl.bind("F8", hl.dsp.exec_cmd([[c=$(brightnessctl --device 'tpacpi::kbd_backlight' get); if [ "$c" -ge 2 ]; then brightnessctl --device 'tpacpi::kbd_backlight' set 0; else brightnessctl --device 'tpacpi::kbd_backlight' set +1; fi]]), { locked = true })

---- REPRODUCCION ----
hl.bind("F10", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("F11", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("F12", hl.dsp.exec_cmd("playerctl next"), { locked = true })

---- SCREENSHOTS ----
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | tee "$HOME/Imágenes/Capturas de pantalla/$(date +'%Y-%m-%d_%H-%M-%S')_region.png" | wl-copy]]))
hl.bind("Print", hl.dsp.exec_cmd([[grim "$HOME/Imágenes/Capturas de pantalla/$(date +'%Y-%m-%d_%H-%M-%S').png" && grim - | wl-copy]]))

---- WINDOW RULES ----
-- Ignora las peticiones de maximizar de las apps (kitty pide maximizarse al abrir)
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
