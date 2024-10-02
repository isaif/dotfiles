local awful = require('awful')

local manager = require('utils.app_tag_manager')
local switch_and_launch = manager.switch_and_launch
local launch_and_toggle = manager.launch_and_toggle

local variables = require('core.user_variables')
local modkey = variables.modkey
-- local terminal = variables.terminal

-- keybindings for different applications
awful.keyboard.append_global_keybindings({
  -- Chrome on tag 8
  awful.key({ modkey }, 'd', function()
    -- launch_and_toggle(8, 'Google-chrome', 'google-chrome-stable')
    launch_and_toggle(8, 'Google-chrome', 'google-chrome-stable')
  end, {
    description = 'launch chrome and toggle it on current tag',
    group = 'custom',
  }),

  awful.key({ modkey, 'Shift' }, 'd', function()
    switch_and_launch(8, 'Google-chrome', 'google-chrome-stable')
  end, {
    description = 'switch to tag 8 and launch Chrome if needed',
    group = 'custom',
  }),

  awful.key({ modkey }, 'f', function()
    -- launch_and_toggle(8, 'Google-chrome', 'google-chrome-stable')
    launch_and_toggle(9, 'kitty', 'kitty')
  end, {
    description = 'launch kitty and toggle it on current tag',
    group = 'custom',
  }),

  -- Terminal on tag 9
  awful.key({ modkey, 'Shift' }, 'f', function()
    switch_and_launch(9, 'kitty', 'kitty')
  end, {
    description = 'switch to tag 1 and launch Terminal if needed',
    group = 'custom',
  }),

  -- Example: VS Code on tag 2
  -- awful.key({ modkey }, 'c', function()
  --   switch_and_launch(2, 'Code', 'code')
  -- end, {
  --   description = 'switch to tag 2 and launch VS Code if needed',
  --   group = 'custom',
  -- }),
})
