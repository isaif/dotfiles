local awful = require('awful')
-- Theme handling library
local beautiful = require('beautiful')

local M = {}

-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
M.set_theme = function()
  beautiful.init('~/.config/awesome/theme.lua')
end

-- This is used later as the default terminal and editor to run.
-- terminal = "xterm"
M.terminal = 'kitty'
M.editor = os.getenv('EDITOR') or 'nano'
M.editor_cmd = M.terminal .. ' -e ' .. M.editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
M.modkey = 'Mod4'

M.mousebuttons = awful.button.names

return M
