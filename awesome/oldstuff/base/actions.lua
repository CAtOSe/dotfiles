local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")



-- ==========================
--    Focus
-- ==========================
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)