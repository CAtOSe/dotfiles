-- =========================
--    Load libraries
-- =========================
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local apps = require("configuration.apps")

-- =========================
--    CONFIG
-- =========================
awesome.set_preferred_icon_size(48)
dock_screen = 1



-- Predefine indicators
local active_ind_path = "/home/paul/.config/awesome/visuals/icons/dock_ind_active.svg"
local inactive_ind_path = "/home/paul/.config/awesome/visuals/icons/dock_ind_inactive.svg"
local none_ind_path = "/home/paul/.config/awesome/visuals/icons/dock_ind_none.svg"


-- Cache variables
app_cache = { }
class_cache = {}
focused_client_class = ""

-- =========================
--    Helper functions
-- =========================
-- Gets app(class) index in the dock (in order)
local function find_pos(class)
    local pos = -1

    for i, c in ipairs(class_cache) do
        if (class == c) then
            pos = i
            break
        end
    end

    return pos
end


-- Get the most relevant client from app
local function get_best_client(class)
    if app_cache[class].clients ~= nil then
        if #app_cache[class].clients == 1 then
            -- App only has 1 client, return it
            return app_cache[class].clients[1]
        else
            local r = app_cache[class].clients[1] -- Default to first client
            for i, c in ipairs(app_cache[class].clients) do
                if c.urgent then
                    r = c
                    break
                elseif c.pid == app_cache[class].last_focused then
                    if r ~= nil then
                        if r.urgent then
                        else
                            r = c
                        end
                    else
                        r = c
                    end
                end
            end
            return r
        end
    end
end


-- Updates focused_client_class.
local function get_focused_class()
    local focused_client = client.focus
    if focused_client then
        focused_client_class = focused_client.class
    else
        focused_client_class = ""
    end
end


-- Fetch new info about the app
local function update_app(class)
    app_cache[class].clients = { }
    for i, c in ipairs(client.get()) do
        if c.class == class and c.valid then
            table.insert(app_cache[c.class].clients, c)
        end
    end
end



-- =========================
--    Dock item menu
-- =========================
-- Dock item menu
local function dock_menu(class)
    local entries = {}

    local params = {
        width = 100
    }

    -- Entries for an open app.
    if app_cache[class].clients then
        -- Add clients
        for i, c in ipairs(app_cache[class].clients) do
            table.insert(entries, {
                c.name,
                function() c:jump_to() end,
                c.icon
            })
        end

        -- Close all
        if #app_cache[class].clients > 0 then
            table.insert(entries, {
                "Close all",
                function()
                    update_app(class)
                    for i, c in ipairs(app_cache[class].clients) do
                        c:kill()
                    end
                    update_app(class)
                end
            })
        end
    end

    -- Does the app have a launch command? (pinned)
    if app_cache[class].launcher then
        table.insert(entries, {
            "New window",
            function()
                awful.spawn(app_cache[class].launcher)
            end
        })
    end
    
    awful.menu(entries):show()
end


-- =========================
--    Dock functions
-- =========================
-- Creates icon from cached data, adds an indicator
local function create_icon(class)
    local icon = {
        layout = wibox.layout.fixed.vertical,
    }

    if (apps.app_icons[class] ~= nil) then
        -- If app is set up with a custom icon, use the custom icon
        local icon_box = {
            image  = apps.app_icons[class], -- Path to app icon
            resize = true,
            forced_height = 48,
            forced_width = 48,
            widget = wibox.widget.imagebox
        }
        table.insert(icon, icon_box)
    else
        -- Use the icon provided by the client
        local icon_box = {
            forced_height = 48,
            forced_width = 48,
            widget = awful.widget.clienticon(app_cache[class].clients[1]),
        }
        table.insert(icon, icon_box)
    end

    local ind = {
        layout = wibox.layout.align.horizontal,
        expand = "outside",
        nil,
        {
            image = none_ind_path,
            resize = true,
            forced_height = 4,
            forced_width = 4,
            widget = wibox.widget.imagebox
        }
    }

    -- Add indicator
    if (app_cache[class].clients ~= nil) then
        if (#app_cache[class].clients > 0) then 
            if (app_cache[class].class == focused_client_class) then
                ind[2].image = active_ind_path
                table.insert(icon, ind)
            else
                ind[2].image = inactive_ind_path
                table.insert(icon, ind)
            end
        else table.insert(icon, ind)
        end
    else table.insert(icon, ind)
    end

    local w = wibox.widget(icon)

    -- Add mouse binds
    w:buttons(gears.table.join(
        awful.button({ }, 1, function()
            update_app(class)
            if app_cache[class].pinned then
                if app_cache[class].clients ~= nil then
                    if #app_cache[class].clients > 0 then
                        local c = get_best_client(class)
                        if c then c:jump_to() end
                    else
                        if app_cache[class].launcher then
                            awful.spawn(app_cache[class].launcher)
                        end
                    end
                else
                    if app_cache[class].launcher then
                        awful.spawn(app_cache[class].launcher)
                    end
                end
            else
                local c = get_best_client(class)
                if c then c:jump_to() end
            end
        end),

        awful.button({ }, 3, function()
            dock_menu(class)
        end)
    ))

    return w
end


-- Updates the icon without rebuilding it
local function update_icon(s, class)
    local icon_layout = s.dock_bar.widget.second.widget
    local index = find_pos(class)
    if index > 0 then
        local ind = icon_layout.children[index].children[2].second -- Select indicator widget
        
        if app_cache[class].clients == nil then
            -- Remove indicator
            ind:set_image(none_ind_path)
        elseif #app_cache[class].clients == 0 then
            -- Remove indicator
            ind:set_image(none_ind_path)
        elseif focused_client_class == class then
            -- Set indicator to active
            ind:set_image(active_ind_path)
        else
            -- Set indicator to inactive
            ind:set_image(inactive_ind_path)
        end
    end
end


-- Set dock width
local function update_dock_width(s)
    local dock_bar = s.dock_bar
    local c = #class_cache
    local width = 48 * c + (c+1) * 5
    -- 48 (icon size) * client count   +
    -- 5 (space size) * (client count + 1)  +
    dock_bar.width = width
end


-- Adds app to the correct table and adds icon to dock
local function add_app(s, c)
    local icon_layout = s.dock_bar.widget.second.widget

    -- Check if client should be in the dock
    if not (c.skip_taskbar) then
        if (app_cache[c.class] ~= nil) then -- Is it already in the list?
            -- App is pinned or already open.
            update_app(c.class)
            update_icon(s, c.class)
        else
            -- App is not already open and is not pinned. Add it.
            app_cache[c.class] = {
                class = c.class,
                name = c.name,
                clients = { c },
            }
            table.insert(class_cache, c.class)
            -- Add icon
            get_focused_class()
            icon_layout:add(create_icon(c.class))
        end
        app_cache[c.class].last_focused = c.pid
    end
    
    update_dock_width(s)
end


-- Removes app from lists and deletes the icon
local function remove_app(s, c)
    local icon_layout = s.dock_bar.widget.second.widget
    get_focused_class()

    -- Update clients
    update_app(c.class)
    
    if (app_cache[c.class].pinned or #app_cache[c.class].clients > 1) then
        -- App is pinned or has more than 1 window open
        -- Do not remove icon from the dock, just update it
        update_icon(s, c.class)
    else
        -- Last window of the app, remove it
        app_cache[c.class] = nil
        local pos = find_pos(c.class)
        if pos > 0 then
            icon_layout:remove(pos)
            table.remove(class_cache, pos)
        end
    end
    
    update_dock_width(s)
end


-- Recalculates items and redraws the dock
local function rebuild_dock_items(s)
    local dock_items_widget = s.dock_bar.widget.second.widget
    dock_items_widget:reset()

    class_cache = {}
    app_cache = {}

    -- Add pinned items first
    for i, app in ipairs(apps.pinned) do
        app["pinned"] = true
        app_cache[app.class] = app
        table.insert(class_cache, app.class)
        dock_items_widget:add(create_icon(app.class)) -- Add icon to dock
    end


    -- Add active apps
    for i, c in ipairs(client.get()) do
        add_app(s, c)
    end
end


-- Creates the whole dock for the first time
function create_dock(s)
    s.dock_bar = awful.wibar({
        position = "bottom",
        screen = s,
        stretch = false,
        ontop = true,
        height = 56
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

    -- Build caches
    rebuild_dock_items(s)

    update_dock_width(s)
end


-- Add dock only to the first screen
create_dock(screen[dock_screen])


-- Call update_dock when adding/removeing clients
client.connect_signal("manage", function(c)
    if c.class == nil then
        -- Some clients don't have a class or set it afterwards (Spotify)
        c:connect_signal("property::class", function(c)
            if c.valid then
                add_app(screen[dock_screen], c)
            end
        end)
        return
    end

    if c.valid then
        add_app(screen[dock_screen], c)
    end
end)

client.connect_signal("unmanage", function(c)
    remove_app(screen[dock_screen], c)
    get_focused_class()
    update_icon(screen[dock_screen], focused_client_class)
end)

client.connect_signal("focus", function (c)
    if app_cache[c.class] then
        get_focused_class()
        update_icon(screen[dock_screen], focused_client_class)
        app_cache[c.class].last_focused = c.pid
    end
end)

client.connect_signal("unfocus", function (c)
    get_focused_class()
    update_icon(screen[dock_screen], c.class)
    app_cache[c.class].last_focused = c.pid
end)

client.connect_signal("request::urgent", function(c)
    -- update_client(c)
end)