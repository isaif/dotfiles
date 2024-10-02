-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

require('awful.autofocus')

-- Theme handling library
local beautiful = require('beautiful')

require('core.error_handling')

local vars = require('core.user_variables')
local modkey = vars.modkey

-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init('~/.config/awesome/theme.lua')

-- {{{ Tag layout
require('core.layout')
-- }}}

-- {{{ Wallpaper
require('ui.wallpaper')
-- }}}

--{{{ Wibar
require('ui.statusbar')
--}}}

--{{{ keybindings
require('keybindings.general')
require('keybindings.layout')
require('keybindings.tags')
require('keybindings.focus')
require('keybindings.clients')
require('keybindings.application')
--}}}

-- {{{ Rules
-- Rules to apply to new clients.
require('core.rules')
-- }}}

-- {{{ Titlebars
require('ui.titlebars')
-- }}}

-- {{{ Notifications
require('ui.notifications')
-- }}}

-- {{{ Mouse settings
require('core.mouse')
-- }}}
