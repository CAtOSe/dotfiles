--[[

     /\                                         
    /  \__      _____  ___  ___  _ __ ___   ___ 
   / /\ \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \
  / ____ \ V  V /  __/\__ \ (_) | | | | | |  __/
 /_/    \_\_/\_/ \___||___/\___/|_| |_| |_|\___|


 >>> Main configuration file. This loads everything else

]]

-- =========================
--    Load libraries
-- =========================
require("user-config")


-- ==========================
--    Theme
-- ==========================
local beautiful = require("beautiful")
beautiful.init('~/.config/awesome/visuals/theme.lua')
-- Make DPI global
local xresources = require("beautiful.xresources")
dpi = xresources.apply_dpi


-- ==========================
--    Modules
-- ==========================
require("modules")


-- ==========================
--    Configuration
-- ==========================
require("configuration")
