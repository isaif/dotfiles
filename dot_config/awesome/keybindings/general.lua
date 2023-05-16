local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
local menubar = require('menubar')

local variables = require('core.user_variables')
local modkey = variables.modkey
local terminal = variables.terminal

local confirmQuitmenu = awful.menu({
  items = {
    {
      'Cancel',
      function()
        do
        end
      end,
    },
    {
      'Quit',
      function()
        awesome.quit()
      end,
    },
  },
})

-- General Awesome keys
awful.keyboard.append_global_keybindings({
  awful.key(
    { modkey },
    's',
    hotkeys_popup.show_help,
    { description = 'show help', group = 'awesome' }
  ),
  awful.key(
    { modkey, 'Control' },
    'r',
    awesome.restart,
    { description = 'reload awesome', group = 'awesome' }
  ),

  awful.key({ modkey, 'Shift' }, 'c', function()
    confirmQuitmenu:show()
  end, { description = 'confirm Awesomewm exit', group = 'awesome' }),

  awful.key({ modkey }, 'x', function()
    awful.prompt.run({
      prompt = 'Run Lua code: ',
      textbox = awful.screen.focused().mypromptbox.widget,
      exe_callback = awful.util.eval,
      history_path = awful.util.get_cache_dir() .. '/history_eval',
    })
  end, { description = 'lua execute prompt', group = 'awesome' }),
  awful.key({ modkey }, 'Return', function()
    awful.spawn(terminal)
  end, { description = 'open a terminal', group = 'launcher' }),
  awful.key({ modkey }, 'r', function()
    awful.screen.focused().mypromptbox:run()
  end, { description = 'run prompt', group = 'launcher' }),
  awful.key({ modkey }, 'p', function()
    menubar.show()
  end, { description = 'show the menubar', group = 'launcher' }),
})
