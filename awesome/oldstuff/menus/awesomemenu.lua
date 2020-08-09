-- =========================
--    Load libraries
-- =========================
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local awful = require("awful")

-- Awesome menu entry
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

-- Main menu
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = awesome_icon,
                                     menu = mymainmenu })