local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local icons = require('icons')

local meter_icon = wibox.widget({
  {
    {
      image = icons.volume,
      resize = true,
      widget = wibox.widget.imagebox,
    },
    margins = dpi(2),
    widget = wibox.container.margin,
  },
  layout = wibox.layout.fixed.horizontal,
})

local tooltip_text = ''

-- pactl based volume widget for pure pipewire setups
local volume_levels = awful.widget.watch(
  'pactl get-sink-volume @DEFAULT_SINK@ | cut -s -d/ -f2,4; pactl get-sink-mute @DEFAULT_SINK@',
  5, -- timeout

  function(widget, stdout)
    local volume_text = ''
    local total_volume = 0
    local channels = {}
    tooltip_text = stdout

    for v in stdout:gmatch('(%d+%%)') do
      -- volume_text = volume_text .. ' ' .. v
      table.insert(channels, v)
      total_volume = total_volume + tonumber(v:sub(1, -2))
    end

    if #channels == 0 then
      volume_text = 'N/A'
    end

    local avg_volume = math.floor(total_volume / #channels)
    volume_text = tostring(avg_volume) .. '%'

    -- local mute = string.match(stdout, 'Mute: (%S+)') or 'N/A'
    local mute = string.match(stdout, 'Mute: (%S+)')
    if mute then
      volume_text = 'mute'
    end

    -- widget:set_markup(volume_text .. ' ' .. mute)
    widget:set_markup(volume_text)
  end
)

local volume = wibox.widget({
  layout = wibox.layout.fixed.horizontal,
  spacing = dpi(3),
  meter_icon,
  volume_levels,
})

local tooltip = awful.tooltip({})

tooltip:add_to_object(volume)

volume:connect_signal('mouse::enter', function()
  tooltip.text = tooltip_text
end)

return volume
