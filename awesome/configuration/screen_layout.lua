-- =========================
--    Load libraries
-- =========================
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')



-- =========================
--    Wallpaper
-- =========================
local function set_wallpaper(screen)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(screen)
        end
        gears.wallpaper.maximized(wallpaper, screen, false)
    end
end



-- =========================
--    Screen layouts
-- =========================
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])
end)

-- No offscreen clients
client.connect_signal(
	'manage',
	function(c)
		awful.placement.no_offscreen(c)
	end
)
