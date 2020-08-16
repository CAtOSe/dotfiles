-- =========================
--    Load libraries
-- =========================
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_xdg_config_home() .. "awesome/visuals/"

local theme = {}


-- =========================
--    Variables
-- =========================

theme.wallpaper = "~/.config/awesome/wallpaper.jpg"

theme.font          = "SF Display 10"


-- =========================
--    Colors
-- =========================
theme.bg_normal     = "#3b302b".."22"
theme.bg_focus      = "#eb7236".."66"
-- theme.bg_urgent     = "#ff0000"

theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#ffffff"
-- theme.fg_urgent     = "#ffffff"

theme.wibar_bg      = "#eb7236" .. "44"

theme.menu_width     = 200
theme.menu_font      = "SF Display 10"
theme.menu_bg_normal = "#ea7135" .. "55"
theme.menu_bg_focus  = "#ea7135" .. "70"


-- =========================
--    Icons
-- =========================
theme.titlebar_close_button_normal = themes_path.."icons/close.svg"
theme.titlebar_close_button_focus = theme.titlebar_close_button_normal

theme.titlebar_minimize_button_normal = themes_path.."icons/minimize.svg"
theme.titlebar_minimize_button_focus = theme.titlebar_minimize_button_normal


theme.titlebar_maximized_button_normal_inactive = themes_path.."icons/maximized_inactive.svg"
theme.titlebar_maximized_button_focus_inactive = theme.titlebar_maximized_button_normal_inactive
theme.titlebar_maximized_button_normal_active = themes_path.."icons/maximized_active.svg"
theme.titlebar_maximized_button_focus_active = theme.titlebar_maximized_button_normal_active

return theme