local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi


local theme = {}

theme.font          = "SF Display 10"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"

return theme