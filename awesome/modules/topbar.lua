-- =========================
--    Load libraries
-- =========================
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local apps = require("configuration.apps")

-- Modules
local task_list = require("modules.task-list")
local clock = require('modules.clock')
local power_menu = require('modules.power-menu')
local keymap = require('modules.keymap')


-- =========================
--    TOPBAR
-- =========================
function create_topbar(s)
    s.top_bar = awful.wibar({
        position = "top",
        screen = s,
        stretch = true,
        ontop = true,
        height = dpi(24),
    })

    s.top_bar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        task_list(s), -- Left (will be task bar)
        clock, -- Middle (will be clock)
        {
            keymap(),
            power_menu,
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        }, -- Right (will be applets)
    }
end

for s in screen do
    create_topbar(s)
end



-- Fullscreen hides topbar
tag.connect_signal(
	'property::selected',
    function(t)
        fullscreen = false

        cls = t:clients()
        for _,c in pairs(cls) do
            if c.fullscreen then
                fullscreen = true
                break
            end
        end

        t.screen.top_bar.visible = not fullscreen
	end
)

client.connect_signal(
	'property::fullscreen',
	function(c)
        c.screen.top_bar.visible = not c.fullscreen
	end
)

client.connect_signal(
	'unmanage',
	function(c)
		if c.fullscreen then
            c.screen.top_bar.visible = not c.fullscreen
		end
	end
)
