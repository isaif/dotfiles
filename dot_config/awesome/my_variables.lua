local M = {}

-- This is used later as the default terminal and editor to run.
-- terminal = "xterm"
M.terminal = 'kitty'
M.editor = os.getenv('EDITOR') or 'nano'
M.editor_cmd = M.terminal .. ' -e ' .. M.editor

-- Keyboard map indicator and switcher
-- M.mykeyboardlayout = awful.widget.keyboardlayout()

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
M.modkey = 'Mod4'

return M
