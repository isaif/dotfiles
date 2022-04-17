require('lualine').setup({
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
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff',
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_c = {
      {
        'filename',
        -- displays file status (readonly status, modified status)
        file_status = true,
        -- 0 = just filename, 1 = relative path, 2 = absolute path
        path = 1,
        shorting_target = 20,
      },
      'lsp_progress',
    },
    -- lualine_c = {'filename'},
    lualine_x = {
      -- 'encoding',
      -- 'fileformat',
      { 'filetype', icons_enabled = false },
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  -- When buffer is inactive
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    -- lualine_c = {'filename'},
    lualine_c = {
      {
        'filename',
        path = 1,
        shorting_target = 40,
      },
    },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
      {
        'tabs',
        max_length = vim.o.columns / 3, -- Maximum width of tabs component.
        -- Note:
        -- It can also be a function that returns
        -- the value of `max_length` dynamically.
        mode = 1, -- 0: Shows tab_nr
        -- 1: Shows tab_name
        -- 2: Shows tab_nr + tab_name

        -- tabs_color = {
        --   -- Same values as the general color option can be used here.
        --   active = 'lualine_{section}_normal', -- Color for active tab.
        --   inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
        -- },
      },
    },
  },
  extensions = { 'fugitive' },
})
