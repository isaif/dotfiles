local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local user_variables = require('core.user_variables')
local modkey = user_variables.modkey
local mousebuttons = user_variables.mousebuttons

-- widgets
local calendar = require('widgets.calendar')

-- Keyboard map indicator and switcher
-- local mykeyboardlayout = awful.widget.keyboardlayout()

local statusbar = function(s)
  -- Each screen has its own tag table.
  awful.tag(
    { '1', '2', '3', '4', '5', '6', '7', '8', '9' },
    s,
    awful.layout.layouts[1]
  )

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox({
    screen = s,
    buttons = {
      awful.button({}, mousebuttons.LEFT, function()
        awful.layout.inc(1)
      end),
      awful.button({}, mousebuttons.RIGHT, function()
        awful.layout.inc(-1)
      end),
      awful.button({}, mousebuttons.SCROLL_UP, function()
        awful.layout.inc(1)
      end),
      awful.button({}, mousebuttons.SCROLL_DOWN, function()
        awful.layout.inc(-1)
      end),
    },
  })

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.noempty,
    buttons = {
      awful.button({}, mousebuttons.LEFT, function(t)
        t:view_only()
      end),
      awful.button({ modkey }, mousebuttons.LEFT, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, mousebuttons.RIGHT, awful.tag.viewtoggle),
      awful.button({ modkey }, mousebuttons.RIGHT, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({}, mousebuttons.SCROLL_UP, function(t)
        awful.tag.viewprev(t.screen)
      end),
      awful.button({}, mousebuttons.SCROLL_DOWN, function(t)
        awful.tag.viewnext(t.screen)
      end),
    },
  })

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = {
      awful.button({}, mousebuttons.LEFT, function(c)
        c:activate({ context = 'tasklist', action = 'toggle_minimization' })
      end),
      awful.button({}, mousebuttons.RIGHT, function()
        awful.menu.client_list({ theme = { width = 250 } })
      end),
      awful.button({}, mousebuttons.SCROLL_UP, function()
        awful.client.focus.byidx(-1)
      end),
      awful.button({}, mousebuttons.SCROLL_DOWN, function()
        awful.client.focus.byidx(1)
      end),
    },
    layout = {
      spacing = 10,
      layout = wibox.layout.fixed.horizontal,
    },
    -- style = {
    --   -- shape_border_width = 1,
    --   -- shape_border_color = '#777777',
    --   -- shape = gears.shape.rounded_bar,
    -- },
    -- widget_template = template,
    -- widget_template = template,
  })

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = 'top',
    screen = s,
    widget = {
      layout = wibox.layout.align.horizontal,
      -- center the tasklist
      expand = 'none',
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
        s.mypromptbox,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        {
          layout = wibox.layout.fixed.horizontal,
          -- mykeyboardlayout,
          wibox.widget.systray(),
          calendar.create(s),
          spacing = 5,
        },
        {
          s.mylayoutbox,
          margins = dpi(2),
          widget = wibox.container.margin,
        },
      },
    },
  })
end

screen.connect_signal('request::desktop_decoration', function(s)
  statusbar(s)
end)
