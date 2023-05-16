local awful = require('awful')

local variables = require('core.user_variables')
local modkey = variables.modkey

awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { modkey, 'Shift' },
    keygroup = 'numrow',
    description = 'move focused client to tag',
    group = 'tag',
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, 'Control', 'Shift' },
    keygroup = 'numrow',
    description = 'toggle focused client on tag',
    group = 'tag',
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  }),
})

client.connect_signal('request::default_mousebindings', function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({ context = 'mouse_click' })
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate({ context = 'mouse_click', action = 'mouse_move' })
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate({ context = 'mouse_click', action = 'mouse_resize' })
    end),
  })
end)

client.connect_signal('request::default_keybindings', function()
  awful.keyboard.append_client_keybindings({
    awful.key({ modkey }, 'f', function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { description = 'toggle fullscreen', group = 'client' }),
    awful.key({ modkey, 'Shift' }, 'q', function(c)
      c:kill()
    end, { description = 'close', group = 'client' }),
    awful.key(
      { modkey, 'Control' },
      'space',
      awful.client.floating.toggle,
      { description = 'toggle floating', group = 'client' }
    ),
    awful.key({ modkey, 'Control' }, 'Return', function(c)
      c:swap(awful.client.getmaster())
    end, { description = 'move to master', group = 'client' }),

    -- Todo: what does this do
    -- awful.key({ modkey }, 'o', function(c)
    --   c:move_to_screen()
    -- end, { description = 'move to screen', group = 'client' }),

    awful.key({ modkey }, 't', function(c)
      c.ontop = not c.ontop
    end, { description = 'toggle keep on top', group = 'client' }),
    awful.key({ modkey }, 'n', function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end, { description = 'minimize', group = 'client' }),
    awful.key({ modkey }, 'm', function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { description = '(un)maximize', group = 'client' }),
    awful.key({ modkey, 'Control' }, 'm', function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, { description = '(un)maximize vertically', group = 'client' }),
    awful.key({ modkey, 'Shift' }, 'm', function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, { description = '(un)maximize horizontally', group = 'client' }),
  })
end)
