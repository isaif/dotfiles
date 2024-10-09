local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

-- Create a new wibox
local mywibox = awful.wibar({
  position = 'bottom',
  screen = 1,
  height = 20,
  bg = beautiful.bg_normal,
})

-- Define the signal bar colors
local colors = {
  '#FF0000', -- Red
  '#FFFF00', -- Yellow
  '#00FF00', -- Green
}

-- Define the number of bars and signal strength (0-100)
local num_bars = 3
local signal_strength = 75

-- Calculate the width and height of each bar
local bar_width = mywibox.height / 2
local bar_height = mywibox.height / 2

-- Calculate the spacing between bars
local bar_spacing = bar_width / 2

-- Calculate the total width of the signal
local signal_width = (num_bars * bar_width) + ((num_bars - 1) * bar_spacing)

-- Calculate the starting x-coordinate of the signal
local signal_x = (mywibox.width - signal_width) / 2

-- Calculate the y-coordinate of the signal
local signal_y = (mywibox.height - bar_height) / 2

-- Add the signal bars to the wibox
mywibox:setup({
  {
    widget = wibox.widget.base.make_widget,
    draw = function(_, cr, width, height)
      -- Draw the signal bars
      for i = 1, num_bars do
        -- Calculate the x-coordinate of the current bar
        local bar_x = signal_x + ((i - 1) * (bar_width + bar_spacing))

        -- Calculate the height of the current bar
        local bar_percent =
          math.max(0, math.min(100, signal_strength - ((i - 1) * 33)))
        local bar_height_percent = bar_percent / 100
        local bar_height_actual = bar_height * bar_height_percent

        -- Draw the bar outline
        cr:set_source_rgb(1, 1, 1)
        cr:rectangle(bar_x, signal_y, bar_width, bar_height)
        cr:stroke()

        -- Draw the bar fill
        cr:set_source_rgb(gears.color.parse_color(colors[i]))
        cr:rectangle(
          bar_x,
          signal_y + (bar_height - bar_height_actual),
          bar_width,
          bar_height_actual
        )
        cr:fill()
      end

      -- Draw the signal dots
      cr:set_source_rgb(1, 1, 1)
      cr:arc(
        signal_x + (bar_width / 2),
        signal_y + (bar_height / 2),
        bar_height / 4,
        0,
        2 * math.pi
      )
      cr:stroke()
      cr:arc(
        signal_x + (bar_width / 2) + (bar_width + bar_spacing),
        signal_y + (bar_height / 2),
        bar_height / 4,
        0,
        2 * math.pi
      )
      cr:stroke()
      cr:arc(
        signal_x + (bar_width / 2) + ((bar_width + bar_spacing) * 2),
        signal_y + (bar_height / 2),
        bar_height / 4,
        0,
        2 * math.pi
      )
      cr:stroke()
    end,
  },
  layout = wibox.layout.stack,
})

-- Add the wibox to the screen
awful.screen.connect_for_each_screen(function(s)
  s.mywibox = mywibox
end)
