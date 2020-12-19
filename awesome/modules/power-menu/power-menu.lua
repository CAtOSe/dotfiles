-- =========================
--    Load libraries
-- =========================
local awful = require('awful')
local wibox = require('wibox')
local gears = require("gears")
local beautiful = require('beautiful')
local icons_path = gears.filesystem.get_configuration_dir() .. "visuals/icons/power-menu/"
---A helper function to print a table's contents.
---@param tbl table @The table to print.
---@param depth number @The depth of sub-tables to traverse through and print.
---@param n number @Do NOT manually set this. This controls formatting through recursion.
function PrintTable(tbl, depth, n)
  n = n or 0;
  depth = depth or 5;

  if (depth == 0) then
      print(string.rep(' ', n).."...");
      return;
  end

  if (n == 0) then
      print(" ");
  end

  for key, value in pairs(tbl) do
      if (key and type(key) == "number" or type(key) == "string") then
          key = string.format("[\"%s\"]", key);

          if (type(value) == "table") then
              if (next(value)) then
                  print(string.rep(' ', n)..key.." = {");
                  PrintTable(value, depth - 1, n + 4);
                  print(string.rep(' ', n).."},");
              else
                  print(string.rep(' ', n)..key.." = {},");
              end
          else
              if (type(value) == "string") then
                  value = string.format("\"%s\"", value);
              else
                  value = tostring(value);
              end

              print(string.rep(' ', n)..key.." = "..value..",");
          end
      end
  end

  if (n == 0) then
      print(" ");
  end
end

-- Prefetch current user name
-- Shouldn't use io.popen, but since this is called only once and only on startup, it's fine.
-- The drawbacks of having this be synchronious outweight the mess async would make
local fullname = io.popen('getent passwd "$USER" | cut -d: -f5 | cut -d, -f1'):read("*all")

-- =========================
--    Power menu
-- =========================
function center_horizontal(w)
  return wibox.widget({
    layout = wibox.layout.align.horizontal,
    expand = 'none',
    nil,
    w
  }) 
end

function create_user_image()
  local path = ""
  if gears.filesystem.file_readable("~/.face") then
    path = "~/.face"
  else
    path = icons_path .. "user-icon.svg"
  end

  return wibox.widget {
    image = path,
    widget = wibox.widget.imagebox,
    forced_width = dpi(128),
    forced_height = dpi(128)
  }
end

function create_user_name()
  print("Create")
  return wibox.widget {
    widget = wibox.widget.textbox,
    markup = '<span foreground="#ffffff">'..fullname..'</span>',
    align = 'center',
    valign = 'center',
    font = 'Inter Bold 18',
  }
end

function power_icon(name, icon, callback)
  local image = {
    image = icons_path .. icon,
    forced_height = dpi(36),
    forced_width = dpi(36),
    widget = wibox.widget.imagebox
  }

  local ib = {
    image,
    margins = dpi(20),
    widget = wibox.container.margin,
  }

  local bgbox = {
    ib,
    bg = "#00000000",
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 8)
    end,
    widget = wibox.container.background
  }

  local text = {
    widget = wibox.widget.textbox,
    markup = '<span foreground="#eeeeee">'..name..'</span>',
    align = 'center',
    valign = 'center',
    font = 'Inter 11',
  }

  local icon = wibox.widget({
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(10),
    bgbox,
    text
  })

  icon.select = function()
    icon.children[1].bg = beautiful.enter_event
  end

  icon.deselect = function()
    icon.children[1].bg = beautiful.leave_event
  end

  icon:buttons(gears.table.join(
    awful.button({ }, 1, function()
      callback()
    end)
  ))

  icon:connect_signal("mouse::enter", icon.select)
  icon:connect_signal("mouse::leave", icon.deselect)

  return icon
end

function create_power_icons()
  local icons = {
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(20),
    power_icon('Power off', 'shutdown.svg', function()
      awesome.emit_signal('module::power_menu:close')
      awful.spawn.with_shell('poweroff')
    end),
    power_icon('Reboot', 'restart.svg', function()
      awesome.emit_signal('module::power_menu:close')
      awful.spawn.with_shell('reboot')
    end),
    power_icon('Hibernate', 'hibernate.svg', function()
      awesome.emit_signal('module::power_menu:close')
      -- hibernate command
    end),
    power_icon('Lock', 'lock-screen.svg', function()
      awesome.emit_signal('module::power_menu:close')
      -- Lock command
    end),
    power_icon('Exit', 'exit.svg', function()
      awesome.emit_signal('module::power_menu:close')
      awesome.quit()
    end)
  }

  return icons
end

function build_menu_items()
  return {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(20),
    {
      layout = wibox.layout.align.horizontal,
      expand = 'none',
      nil,
      create_user_image()
    },
    create_user_name(),
    center_horizontal(create_power_icons())
  }
end


function create_menu(s)
  s.power_menu = wibox {
		screen = s,
		type = 'splash',
		visible = false,
		ontop = true,
		bg = beautiful.bg_power_menu,
		fg = beautiful.fg_normal,
		height = s.geometry.height,
		width = s.geometry.width,
		x = s.geometry.x,
		y = s.geometry.y
  }

  s.power_menu:buttons(gears.table.join(
    awful.button({ }, 1, function(w)
      close_menu(s)
    end)
))
  
  s.power_menu:setup {
    layout = wibox.layout.align.vertical,
		expand = 'none',
    nil,
    build_menu_items()
  }
end

function open_menu(s)
  if s.power_menu ~= nil then
    s.power_menu.visible = true
  else
    create_menu(s)
  end
end

function close_menu(s)
  if s.power_menu then
    s.power_menu.visible = false
  end
end

screen.connect_signal('request::desktop_decoration', function(s)
	create_menu(s)
end)

awesome.connect_signal('module::power_menu:close', function()
  for s in screen do
    close_menu(s)
  end
end)

return open_menu