local telescope = require('telescope')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

telescope.setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    layout_config = {
      -- preview_width = 0.7,
      preview_width = 80,
    },
    mappings = {
      i = {
        ['<C-p>'] = action_layout.toggle_preview,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        -- cycle previewer for git commits to show full message
        ['<C-n>'] = actions.cycle_previewers_next,
        -- ['<C-p>'] = actions.cycle_previewers_prev,
      },
      n = {
        ['<C-p>'] = action_layout.toggle_preview,
        -- cycle previewer for git commits to show full message
        ['<C-n>'] = actions.cycle_previewers_next,
        -- ['<C-p>'] = actions.cycle_previewers_prev,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
})

-- using fzf sorter for telescope
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
