local icon_theme_path = "/usr/share/icons/Papirus/48x48/apps/"

local apps = {}

apps.app_icons = {
    firefox = icon_theme_path .. "firefox.svg",
    ["code-oss"]  = icon_theme_path .. "code.svg",
    kitty = icon_theme_path .. "kitty.svg",
    ["figma-linux"] = icon_theme_path .. "figma.svg",
}

apps.pinned = {
    {
        name = "Firefox",
        launcher = "firefox"
    }
}

return apps