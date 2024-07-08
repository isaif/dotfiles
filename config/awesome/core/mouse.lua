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

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
  c:activate({ context = 'mouse_enter', raise = false })
end)
