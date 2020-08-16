local icon_theme_path = "/usr/share/icons/Papirus/48x48/apps/"

local apps = {}

apps.app_icons = {
    firefox = icon_theme_path .. "firefox.svg",
    ["code-oss"]  = icon_theme_path .. "code.svg",
    kitty = icon_theme_path .. "kitty.svg",
    ["figma-linux"] = icon_theme_path .. "figma.svg",
    ["Xephyr"] = icon_theme_path .. "activity-log-manager.svg",
    ["Org.gnome.Nautilus"] = icon_theme_path .. "org.gnome.files.svg"
}

-- NOTE: Pinned apps MUST have an app_icon.
-- I might implement an automatic icon search later.

apps.pinned = {
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
}

return apps
