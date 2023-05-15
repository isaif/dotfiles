version = '0.21.1'

local home = os.getenv('HOME')
package.path = home
  .. '/.config/xplr/plugins/?/init.lua;'
  .. home
  .. '/.config/xplr/plugins/?.lua;'
  .. package.path

require('icons').setup()

require('tri-pane').setup()

-- If you set as_default_layout = false,
-- switch to this mode manually by pressing ctrl-w and then T.
-- require('tri-pane').setup({
--   layout_key = 'T', -- In switch_layout mode
--   as_default_layout = true,
--   left_pane_width = { Percentage = 20 },
--   middle_pane_width = { Percentage = 50 },
--   right_pane_width = { Percentage = 30 },
--   left_pane_renderer = custom_function_to_render_left_pane,
--   right_pane_renderer = custom_function_to_render_right_pane,
-- })
