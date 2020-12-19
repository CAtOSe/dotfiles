-- =========================
--    Load libraries
-- =========================
local awful = require('awful')
local wibox = require('wibox')
local gears = require("gears")
local beautiful = require('beautiful')
local icons_path = gears.filesystem.get_configuration_dir() .. "visuals/icons/"


-- =========================
--    Keymap
-- =========================
local create_widget = function()
  local kb = awful.widget.keyboardlayout()
  kb.widget.font = "Inter Bold 10"
  kb.widget.text = string.upper(kb.widget.text)

  kb:connect_signal("widget::redraw_needed", function(w)
    w.widget.text = string.upper(w.widget.text)
  end)

  local bg = wibox.container.background(wibox.container.margin(kb, beautiful.topbar_padding, beautiful.topbar_padding))

  bg:connect_signal("mouse::enter", function(w)
    bg.bg = beautiful.enter_event
  end)

  bg:connect_signal("mouse::leave", function(w)
    bg.bg = beautiful.leave_event
  end)

  return bg
end

return create_widget