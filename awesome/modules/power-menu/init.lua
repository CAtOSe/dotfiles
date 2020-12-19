-- =========================
--    Load libraries
-- =========================
local awful = require('awful')
local wibox = require('wibox')
local gears = require("gears")
local beautiful = require('beautiful')
local icons_path = gears.filesystem.get_configuration_dir() .. "visuals/icons/power-menu/"
local power_menu = require('modules.power-menu.power-menu')


-- =========================
--    Power menu icon
-- =========================
local ib = wibox.widget.imagebox(icons_path .. "shutdown.svg", true)
local icon = wibox.container.margin(ib, dpi(4) + beautiful.topbar_padding, dpi(4) + beautiful.topbar_padding, dpi(4), dpi(4))
local icon_bg = wibox.container.background(icon)

icon_bg:buttons(gears.table.join(
    awful.button({ }, 1, function(w)
      -- open menu
      power_menu(mouse.screen)
    end)
))

icon_bg:connect_signal("mouse::enter", function()
  icon_bg.bg = beautiful.enter_event
end)

icon_bg:connect_signal("mouse::leave", function()
  icon_bg.bg = beautiful.leave_event
end)

return icon_bg