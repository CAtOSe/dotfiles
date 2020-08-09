local awful = require("awful")

-- Common settings
terminal = "kitty"
editor = os.getenv("EDITOR") or "micro"
editor_cmd = terminal .. " -e " .. editor

wallpaper_path = "~/.config/awesome/wallpaper.jpg"


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
}