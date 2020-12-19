-- =========================
--    Load libraries
-- =========================
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local filesystem = require("gears.filesystem")
local themes_path = filesystem.get_configuration_dir() .. "/visuals/"

local theme = {}


-- =========================
--    Variables
-- =========================
theme.wallpaper = "~/.config/awesome/wallpaper.jpg"

theme.font = 'Inter Regular 10'
theme.font_bold = 'Inter Bold 10'

-- =========================
--    Bars
-- =========================
theme.bar_bg        = "#424B59".."aa"
theme.bar_bg_focus  = "#2A3342".."55"
theme.bar_border    = dpi(1)
theme.bar_border_bg = "#2D343D"
theme.bar_radius    = dpi(4)
theme.topbar_padding= dpi(3)
theme.wibar_bg      = theme.bar_bg

theme.bg_power_menu = "#656A8F".."aa"


-- =========================
--    Titlebars
-- =========================
theme.bg_focus      = "#4A71B0".."aa"
theme.bg_normal     = "#768E9C".."90" -- defocused
theme.bg_urgent     = "#ff0000"

theme.fg_normal     = "#E8DBD5"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"

theme.titlebar_close_button_normal = themes_path.."icons/titlebar/close.svg"
theme.titlebar_close_button_focus = theme.titlebar_close_button_normal

theme.titlebar_minimize_button_normal = themes_path.."icons/titlebar/minimize.svg"
theme.titlebar_minimize_button_focus = theme.titlebar_minimize_button_normal

theme.titlebar_maximized_button_normal_inactive = themes_path.."icons/titlebar/maximized_inactive.svg"
theme.titlebar_maximized_button_focus_inactive = theme.titlebar_maximized_button_normal_inactive
theme.titlebar_maximized_button_normal_active = themes_path.."icons/titlebar/maximized_active.svg"
theme.titlebar_maximized_button_focus_active = theme.titlebar_maximized_button_normal_active

theme.titlebar_close_button_normal_hover = themes_path.."icons/titlebar/close_hover.svg"
theme.titlebar_close_button_focus_hover = theme.titlebar_close_button_normal_hover

theme.titlebar_minimize_button_normal_hover = themes_path.."icons/titlebar/minimize_hover.svg"
theme.titlebar_minimize_button_focus_hover = theme.titlebar_minimize_button_normal_hover

theme.titlebar_maximized_button_normal_inactive_hover = themes_path.."icons/titlebar/maximized_inactive_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover = theme.titlebar_maximized_button_normal_inactive_hover
theme.titlebar_maximized_button_normal_active_hover = themes_path.."icons/titlebar/maximized_active_hover.svg"
theme.titlebar_maximized_button_focus_active_hover = theme.titlebar_maximized_button_normal_active_hover


-- =========================
--    Context Menu
-- =========================
theme.menu_font = 'Inter Regular 11'
theme.menu_submenu = '' -- ➤

theme.menu_height = dpi(34)
theme.menu_width = dpi(200)
theme.menu_border_width = dpi(1)

theme.menu_bg_normal = "#404D54".."44"
theme.menu_bg_focus  = "#4A71B0".."aa"
theme.menu_fg_normal = '#ffffff'
theme.menu_fg_focus = '#ffffff'
theme.menu_border_color = "#768E9C"


-- UI events
theme.leave_event = transparent
theme.enter_event = '#ffffff' .. '10'
theme.press_event = '#ffffff' .. '15'
theme.release_event = '#ffffff' .. '10'

return theme