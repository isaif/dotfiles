local awful = require('awful')

local manager = require('utils.app_tag_manager')
local switch_and_launch = manager.switch_and_launch
local launch_and_toggle = manager.launch_and_toggle

local variables = require('core.user_variables')
local modkey = variables.modkey
-- local terminal = variables.terminal

-- keybindings for different applications
awful.keyboard.append_global_keybindings({
  -- FIX: this doesn't work if chrome is not already launched in tag 8
  -- i.e. toggle is working but toggling with launchig is not working
  awful.key({ modkey, 'Shift' }, 'd', function()
    launch_and_toggle(8, 'Google-chrome', 'google-chrome-stable')
  end, {
    description = 'launch chrome and toggle it on current tag',
    group = 'application',
  }),

  awful.key({ modkey }, 'd', function()
    switch_and_launch(8, 'Google-chrome', 'google-chrome-stable')
  end, {
    description = 'switch to tag 8 and launch Chrome if needed',
    group = 'application',
  }),

  awful.key({ modkey, 'Shift' }, 'f', function()
    launch_and_toggle(9, 'kitty', 'kitty')
  end, {
    description = 'launch terminal and toggle it on current tag',
    group = 'application',
  }),

  awful.key({ modkey }, 'f', function()
    switch_and_launch(9, 'kitty', 'kitty')
  end, {
    description = 'switch to tag 1 and launch Terminal if needed',
    group = 'application',
  }),

  -- Example: VS Code on tag 2
  -- awful.key({ modkey }, 'c', function()
  --   switch_and_launch(2, 'Code', 'code')
  -- end, {
  --   description = 'switch to tag 2 and launch VS Code if needed',
  --   group = 'custom',
  -- }),
})
