local icon_theme_path = icon_theme .. "48x48/apps/"

local apps = {}

apps.app_icons = {
    firefox = icon_theme_path .. "firefox.svg",
    ["code-oss"]  = icon_theme_path .. "code.svg",
    kitty = icon_theme_path .. "kitty.svg",
    ["figma-linux"] = icon_theme_path .. "figma.svg",
    ["Xephyr"] = icon_theme_path .. "activity-log-manager.svg",
    ["Org.gnome.Nautilus"] = icon_theme_path .. "system-file-manager.svg",
    ["rofi"] = icon_theme_path .. "applications-all.svg",
    ["Spotify"] = icon_theme_path .. "spotify.svg",
    ["discord"] = icon_theme_path .. "discord.svg"
}

-- NOTE: Pinned apps MUST have an app_icon.
-- I might implement an automatic icon search later.

apps.pinned = {
    {
        name = "App Launcher",
        launcher = app_launcher,
        class = "rofi"
    },
    {
        name = "Firefox",
        launcher = "firefox",
        class = "firefox"
    },
    {
        name = "Code",
        launcher = "code",
        class = "code-oss"
    },
    {
    	name = "Files",
    	launcher = "nautilus",
    	class = "Org.gnome.Nautilus"
    },
    {
        name = "Kitty",
        launcher = "kitty",
        class = "kitty"
    },
    {
        name = "Spotify",
        launcher = "spotify",
        class = "Spotify"
    },
    {
        name = "Discord",
        launcher = "discord",
        class = "discord"
    },
}

return apps
