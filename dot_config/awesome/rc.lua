-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- Standard awesome library
local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
-- Widget and layout library
local wibox = require('wibox')
-- Theme handling library
local beautiful = require('beautiful')
-- Notification library
local naughty = require('naughty')

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal('request::display_error', function(message, startup)
  naughty.notification({
    urgency = 'critical',
    title = 'Oops, an error happened'
      .. (startup and ' during startup!' or '!'),
    message = message,
  })
end)
-- }}}

-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init('~/.config/awesome/theme.lua')

-- {{{ Wallpaper
screen.connect_signal('request::wallpaper', function(s)
  awful.wallpaper({
    screen = s,
    widget = {
      {
        image = beautiful.wallpaper,
        upscale = true,
        downscale = true,
        widget = wibox.widget.imagebox,
      },
      valign = 'center',
      halign = 'center',
      tiled = false,
      widget = wibox.container.tile,
    },
  })
end)
-- }}}

--{{{ Set Wibar component
local my_bar = require('my_bar').my_bar

screen.connect_signal('request::desktop_decoration', function(s)
  my_bar(s)
end)
--}}}

-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal('request::default_layouts', function()
  awful.layout.append_default_layouts({
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
  })
end)
-- }}}

-- {{{ Store the list of mouse buttons to be applied on the wallpaper
-- (also known as root window).
-- root.buttons(gears.table.join(
--   -- Remove right click on desktop
--   -- awful.button({}, 3, function()
--   --   mymainmenu:toggle()
--   -- end),
--
--   -- scroll on wallpaper area to change tags
--   awful.button({}, 4, awful.tag.viewnext),
--   awful.button({}, 5, awful.tag.viewprev)
-- ))
-- }}}

local keybindings = require('keybindings')

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keybindings.clientkeys,
      buttons = keybindings.clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        'DTA', -- Firefox addon DownThemAll.
        'copyq', -- Includes session name in class.
        'pinentry',
      },
      class = {
        'Arandr',
        'Blueman-manager',
        'Gpick',
        'Kruler',
        'MessageWin', -- kalarm.
        'Sxiv',
        'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
        'Wpa_gui',
        'veromix',
        'xtightvncviewer',
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        'Event Tester', -- xev.
      },
      role = {
        'AlarmWindow', -- Thunderbird's calendar.
        'ConfigManager', -- Thunderbird's about:config.
        'pop-up', -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true },
  },

  -- Add titlebars to normal clients and dialogs
  -- { rule_any = {type = { "normal", "dialog" }
  {
    rule_any = { type = { 'dialog' } },
    properties = { titlebars_enabled = true },
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then
    awful.client.setslave(c)
  end

  if
    awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position
  then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal('request::titlebars', function(c)
  -- buttons for the titlebar
  local buttons = {
    awful.button({}, 1, function()
      c:activate({ context = 'titlebar', action = 'mouse_move' })
    end),
    awful.button({}, 3, function()
      c:activate({ context = 'titlebar', action = 'mouse_resize' })
    end),
  }

  awful.titlebar(c).widget = {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Middle
      { -- Title
        halign = 'center',
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  }
end)
-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
  c:activate({ context = 'mouse_enter', raise = false })
end)
-- }}}
