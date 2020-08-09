-- =========================
--    Load libraries
-- =========================
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local apps = require("configuration.apps")

function DebugPrint(m)
print("====== DEBUG ======")
print(m)
print("===================")
end

awesome.set_preferred_icon_size(48)

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


local function create_dock_icon(c)
    print(c.class)

    local icon = {
        layout = wibox.layout.fixed.vertical,
    }

    if (apps.app_icons[c.class] ~= nil) then
        -- If app is set up with a custom icon, use the custom icon
        local icon_box = {
            image  = apps.app_icons[c.class], -- Path to app icon
            resize = true,
            forced_height = 48,
            forced_width = 48,
            widget = wibox.widget.imagebox
        }
        table.insert(icon, icon_box)
    else
        -- If app doesn't have custom icon, use the default
        local icon_box = {
            forced_height = 48,
            forced_width = 48,
            widget = awful.widget.clienticon(c),
        }
        table.insert(icon, icon_box)
    end

    return wibox.widget(icon)
end


function update_dock(s)
    local dock_items = s.dock_bar.widget.second.widget
    dock_items:reset()
    -- sample_text:emit_signal("widget::redraw_needed")

    print("---------")
    for _, c in ipairs(client.get()) do
        local r = create_dock_icon(c)
        if type(r) == "table" then
            dock_items:add(r)
        end
    end
end

function create_dock(s)
    s.dock_bar = awful.wibar({
        position = "bottom",
        screen = s,
        stretch = false,
        ontop = true,
        width = 500,
        height = 54
    })

    -- Item (icon) host layout
    local dock_items = {
        layout = wibox.layout.fixed.horizontal,
        spacing = 5,
        {
            markup = "Sample Text",
            widget = wibox.widget.textbox
        }
    }

    s.dock_bar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "outside",
        nil, -- Left
        {
            widget = wibox.container.margin,
            top = 1,
            dock_items,
        }
    }
end

-- Add dock only to the first screen
create_dock(screen[1])

-- Call update_dock when adding/removeing clients
client.connect_signal("list", function(c) update_dock(screen[1]) end)