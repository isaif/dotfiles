local wibox = require('wibox')
local awful = require('awful')

local my_variables = require('my_variables')
local modkey = my_variables.modkey
local mousebuttons = my_variables.mousebuttons

-- Keyboard map indicator and switcher
-- local mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
local mytextclock = wibox.widget({
  format = ' %a %b %d, %I:%M %p ',
  widget = wibox.widget.textclock,
})

local M = {}

M.my_bar = function(s)
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
    filter = awful.widget.taglist.filter.all,
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
  })

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = 'top',
    screen = s,
    widget = {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
        s.mypromptbox,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        -- mykeyboardlayout,
        wibox.widget.systray(),
        mytextclock,
        s.mylayoutbox,
      },
    },
  })
end

return M
