local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local icons = require('icons')

local meter_icon = wibox.widget({
  {
    {
      image = icons.disk,
      resize = true,
      widget = wibox.widget.imagebox,
    },
    margins = dpi(2),
    widget = wibox.container.margin,
  },
  layout = wibox.layout.fixed.horizontal,
})

-- btrfs root df
local myrootfs = awful.widget.watch(
  'btrfs filesystem df -g /',
  600, -- 10 minutes
  function(widget, stdout)
    local total, used =
      string.match(stdout, 'Data.-total=(%d+%.%d+)GiB.-used=(%d+%.%d+)GiB')

    -- local percent_used = math.ceil((tonumber(used) / tonumber(total)) * 100)
    --
    local approx_used = string.format('%.0f', used)

    -- customize here
    widget:set_text(' ' .. approx_used .. 'G')
  end
)

local btrfs_df = wibox.widget({
  layout = wibox.layout.fixed.horizontal,
  -- spacing = dpi(1),
  meter_icon,
  myrootfs,
})

return btrfs_df
