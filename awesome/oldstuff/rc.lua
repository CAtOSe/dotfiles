--[[

     /\                                         
    /  \__      _____  ___  ___  _ __ ___   ___ 
   / /\ \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \
  / ____ \ V  V /  __/\__ \ (_) | | | | | |  __/
 /_/    \_\_/\_/ \___||___/\___/|_| |_| |_|\___|



 *****  *      ****
 *   *  *      *   *
 *   *  *      *   *
 *****  *****  ****


 >>> Main configuration file. This loads everything else

]]

-- ==========================
--    User config
-- ==========================
require("user-config")


-- =========================
--    Configurations
-- =========================
-- Keybinds and mousebinds
require('configuration/binds')
-- Window class rules
require('configuration/rules')



-- =========================
--    Base
-- =========================
-- Error messages
require("base/errors")
-- Screen layouts
require('base/layout')
-- Actions / Events
require('base/actions')



-- =========================
--    Visuals
-- =========================
-- Load theme
local beautiful = require("beautiful")
beautiful.init('~/.config/awesome/theme.lua')
require('visual')

