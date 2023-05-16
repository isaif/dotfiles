local awful = require('awful')

local variables = require('core.user_variables')
local modkey = variables.modkey

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
  awful.key(
    { modkey },
    'i',
    awful.tag.viewprev,
    { description = 'view previous', group = 'tag' }
  ),
  awful.key(
    { modkey },
    'o',
    awful.tag.viewnext,
    { description = 'view next', group = 'tag' }
  ),
  awful.key(
    { modkey },
    'Escape',
    awful.tag.history.restore,
    { description = 'go back', group = 'tag' }
  ),

  awful.key({
    modifiers = { modkey },
    keygroup = 'numrow',
    description = 'only view tag',
    group = 'tag',
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, 'Control' },
    keygroup = 'numrow',
    description = 'toggle tag',
    group = 'tag',
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),
})
