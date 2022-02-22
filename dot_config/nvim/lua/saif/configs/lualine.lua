require('lualine').setup{
  options = {
    icons_enabled = true,
    -- theme = 'auto',
    -- component_separators = { left = '', right = ''},
    section_separators = '',
    -- section_separators = { left = '', right = ''},
    -- disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      'diff',
      {'diagnostics', sources={'nvim_diagnostic'}}
    },
    lualine_c = {
      {
        'filename',
        -- displays file status (readonly status, modified status)
        file_status = true,
        -- 0 = just filename, 1 = relative path, 2 = absolute path
        path = 1,
        shorting_target = 20
      },
    },
    -- lualine_c = {'filename'},
    lualine_x = {
      -- 'encoding',
      -- 'fileformat',
      {'filetype', icons_enabled = false },
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    -- lualine_c = {'filename'},
    lualine_c = {
      {
        'filename',
        path = 1,
        shorting_target = 40
      }
    },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

