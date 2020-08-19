-- =========================
--    Load libraries
-- =========================
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")



-- =========================
--    Global keybinds
-- =========================
globalkeys = gears.table.join(
	-- Quit Awesome  Mod + Ctrl + Q
	awful.key({ modkey, "Control"}, "q", awesome.quit,
	          { description = "quit awesome", group = "awesome"}),

	-- Restart Awesome  Mod + Ctrl + R
	awful.key({ modkey, "Control"}, "r", awesome.restart,
	          { description = "reload awesome", group = "awesome"}),

	-- Open Terminal (user-config.lua)  Mod + Enter
	awful.key({ modkey, }, "Return", function () awful.spawn(terminal) end,
	          { description = "open terminal", group = "launcher"}),

	-- Open Launcher (user-config.lua)  Mod + Enter
	awful.key({ modkey, }, "d", function () awful.spawn(app_launcher) end,
			  { description = "open launcher", group = "launcher"}),
			  
	-- Switch focus to last client  Mod + Tab
	awful.key({ modkey, }, "Tab", function () 
		awful.client.focus.history.previous()

		if client.focus then
			client.focus:raise()
		end
	end,
	{ description = "focus last client", group = "awesome"}),

	-- Kill focused client  Mod + Shift + Q
	awful.key({ modkey, "Shift" }, "q", function ()
		if client.focus then
			client.focus:kill()
		end
	end,
	{ description = "kill client", group = "awesome"})
)



-- Add tag switch shortcuts
for i = 1, 4 do
	globalkeys = gears.table.join(
		globalkeys,
		
		-- Switch to tag
		awful.key({ modkey }, "#" .. i + 9,
		function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
		end,
		{ description = "view tag #"..i, group = "tag" }),

		-- Move client to tag
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
		function ()
			if client.focus then
				local c = client.focus

				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
				
				-- Make sure client is not moved off screen
				awful.placement.no_offscreen(c)
			end
		end,
		{description = "move focused client to tag #"..i, group = "tag"})
	)
end

-- Set keybinds
root.keys(globalkeys)
