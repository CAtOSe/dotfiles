local awful = require("awful")
local filesystem = require('gears.filesystem')
local config_path = filesystem.get_configuration_dir()

-- Common settings
terminal = "kitty"
editor = os.getenv("EDITOR") or "micro"
editor_cmd = terminal .. " -e " .. editor

app_launcher = "rofi -show drun -theme " .. config_path .. "/external/rofi/app-launcher.rasi"
app_run = "rofi -show drun -theme " .. config_path .. "/external/rofi/run.rasi"

media_controls = {
	playpause = 'playerctl play-pause',
	next = 'playerctl next',
	prev = 'playerctl previous'
}

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
}

-- Wallpaper path
wallpaper = "~/.config/awesome/wallpaper.jpg"

-- Icon theme
icon_theme = "/usr/share/icons/Papirus/"
