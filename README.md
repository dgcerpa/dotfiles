# dotfiles

Personal configuration files for Arch Linux with Hyprland.

![Desktop](docs/screenshots/desktop.png)

## Setup

|                    |                                                        |
| ------------------ | ------------------------------------------------------ |
| **OS**             | Arch Linux                                             |
| **Compositor**     | Hyprland (Wayland, launched from SDDM, no UWSM)        |
| **Config format**  | Lua (`hyprland.lua`)                                   |
| **Login manager**  | SDDM · `sddm-astronaut-theme`, `black_hole` variant     |
| **Bar**            | Waybar                                                 |
| **Launcher**       | wofi                                                   |
| **Terminal**       | kitty                                                  |
| **Shell**          | bash                                                   |
| **File managers**  | Thunar (GUI) · yazi (TUI)                              |
| **Editor**         | micro                                                  |
| **System monitor** | btop                                                   |
| **Visualizer**     | cava                                                   |
| **Fetch**          | fastfetch (runs on interactive shells)                 |
| **Media player**   | mpv                                                    |
| **Wallpaper**      | hyprpaper, picked at random by a script on login       |
| **GTK theme**      | adw-gtk3-dark · Papirus-Dark · Bibata-Modern-Ice 24px  |

## Palette

Every component — compositor borders, bar, launcher, terminal, file manager —
draws from the same set of colours.

| Colour              | Hex       | Used for                                 |
| ------------------- | --------- | ---------------------------------------- |
| ink                 | `#050b1a` | terminal background, text on accents     |
| deep                | `#0a1430` | panel and pill backgrounds               |
| navy                | `#0f1d3f` | raised surfaces                          |
| azure               | `#1e4ed8` | selection background                     |
| bright              | `#3b82f6` | primary accent, active workspace, cursor |
| cyan                | `#38bdf8` | secondary accent, paths, volume          |
| ice                 | `#a5cdff` | muted foreground                         |
| paper               | `#e8efff` | foreground                               |
| amber               | `#fbbf24` | brightness, warnings, marks              |
| red / green / mauve | `#f87171` `#4ade80` `#c084fc` | errors, success, highlights |

Window borders use a 45° gradient from `bright` to `cyan`.

## What's in this repo

```
dotfiles/
├── hypr/         # compositor: hyprland.lua, hyprpaper.conf, wallpaper script
├── waybar/       # top bar: modules, stylesheet, power-menu script
├── wofi/         # application launcher
├── kitty/        # terminal emulator
├── yazi/         # terminal file manager theme
├── bash/         # .bashrc (conda init, fastfetch, yazi `y` helper)
├── gtk/          # GTK 3/4 settings and bookmarks
├── xdg/          # mimeapps.list — default application associations
├── btop/         # system monitor
├── cava/         # audio visualizer, with shaders and themes
├── fastfetch/    # system fetch
├── micro/        # terminal text editor
├── mpv/          # media player
├── docs/
│   └── screenshots/
├── LICENSE
├── .gitignore
└── README.md
```

Each top-level folder mirrors the structure relative to `$HOME`, so the tree is
GNU Stow compatible.

## Requirements

Official repositories:

```bash
sudo pacman -S hyprland hyprpaper waybar wofi kitty thunar tumbler gvfs yazi \
               btop cava fastfetch micro mpv stow \
               brightnessctl playerctl grim slurp wl-clipboard \
               pavucontrol blueman network-manager-applet \
               adw-gtk-theme papirus-icon-theme
```

Supporting tools for yazi previews and search:

```bash
sudo pacman -S poppler ffmpegthumbnailer fd ripgrep imagemagick
```

AUR:

```bash
yay -S bibata-cursor-theme sddm-astronaut-theme
```

## Install

```bash
git clone https://github.com/dgcerpa/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow hypr waybar wofi kitty yazi bash gtk xdg btop cava fastfetch micro mpv
```

One component at a time:

```bash
stow hypr
```

To remove the symlinks:

```bash
stow -D hypr waybar wofi kitty yazi bash gtk xdg btop cava fastfetch micro mpv
```

Stow refuses to overwrite existing files, so move or back up anything already in
`~/.config/` first. Note that `stow bash` will try to link `~/.bashrc`, which
almost certainly already exists.

## Notes

**Hyprland is configured in Lua, not hyprlang.** The choice between
`hyprland.lua` and `hyprland.conf` is made once at startup: if the `.lua` exists,
the `.conf` is ignored entirely. Support for `.conf` is being removed in Hyprland
0.57. Keybindings reload with `hyprctl reload`; environment variables and the
config-format choice need a full session restart.

**The wallpaper config is generated.** `hypr/.config/hypr/scripts/random-wallpaper.sh`
picks an image at random from `~/Imágenes/Wallpapers/` and rewrites
`hyprpaper.conf` on every login, so editing that file by hand has no effect.
Wallpapers themselves are not in this repo — drop your own into that folder.
hyprpaper 0.8 changed to block syntax (`wallpaper { ... }`); the older flat form
is ignored silently.

**The XDG desktop portal loses a startup race** with the compositor and is
restarted from the autostart block after a two-second delay. The handful of
failed attempts in the journal at login are expected.

**Not covered by this repo:**

- `gsettings` values, which live in dconf's binary database. After a fresh
  install, re-run:

  ```bash
  gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
  gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
  gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  ```

  `color-scheme` is the one that matters most: GTK4 applications ignore
  `gtk-theme` and decide their appearance from it.

- Qt theming (`qt6ct`, Kvantum). Left in an intermediate state and not
  reproducible; Qt applications stay light.
- SDDM configuration, which lives in `/etc/sddm.conf.d/`.
- Wallpapers.

## License

MIT — see [LICENSE](LICENSE).
