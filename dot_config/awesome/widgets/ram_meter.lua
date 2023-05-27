local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local icons = require('icons')

local meter = awful.widget.watch('ram_used', 10, function(widget, stdout)
  widget:set_text(string.match(stdout, '%d*%.?%d+[%a]'))
end)

local meter_icon = wibox.widget({
  {
    {
      image = icons.memory,
      resize = true,
      widget = wibox.widget.imagebox,
    },
    margins = dpi(2),
    widget = wibox.container.margin,
  },
  layout = wibox.layout.fixed.horizontal,
})

local ram_meter = wibox.widget({
  layout = wibox.layout.fixed.horizontal,
  spacing = dpi(3),
  meter_icon,
  meter,
})

return ram_meter
