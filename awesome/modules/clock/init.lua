-- =========================
--    Load libraries
-- =========================
local wibox = require("wibox")


-- =========================
--    Clock
-- =========================
local clock = wibox.widget.textclock(
  '<span font="Inter Bold 10">%I:%M %p</span>',
  1
)

local clock_box = wibox.container.margin(
  clock,
  dpi(16),
  dpi(16)
)

return clock_box