-- =========================
--    Load libraries
-- =========================
local awful = require('awful')
local wibox = require('wibox')
local gears = require("gears")



-- =========================
--    Titlebar
-- =========================
client.connect_signal("request::titlebars", function(c)
    -- Mouse actions when clicked on titlebar
    local mouse_keys = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    local titlebar_middle = { -- Middle
        nil,
        awful.titlebar.widget.titlewidget(c),
        buttons = mouse_keys,
        expand = "outside",
        layout = wibox.layout.align.horizontal
    }

    local function resize_button(button_widget, size) 
        return wibox.widget {
            {
                nil,
                button_widget,
                expand = "outside",
                layout = wibox.layout.align.vertical
            },
            forced_height = size,
            forced_width = size,
            widget = wibox.container.background
        }
    end

    local titlebar_right = { -- Right
        resize_button(awful.titlebar.widget.minimizebutton(c), 20),
        resize_button(awful.titlebar.widget.maximizedbutton(c), 20),
        resize_button(awful.titlebar.widget.closebutton(c), 20),
        layout = wibox.layout.fixed.horizontal()
    }

    -- Set up a titlebar
    awful.titlebar(c, {
        size = dpi(28)
    }) : setup {
        nil,
        titlebar_middle,
        titlebar_right,
        layout = wibox.layout.align.horizontal
    }
end)
