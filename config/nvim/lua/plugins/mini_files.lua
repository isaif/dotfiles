return {
  'echasnovski/mini.files',
  keys = {
    {
      '<F1>',
      function()
        local MiniFiles = require('mini.files')
        if not MiniFiles.close() then
          MiniFiles.open()
        end
      end,
    },
  },
  -- opts = {
  --   windows = {
  --     preview = true,
  --   },
  -- },
  config = function(_, opts)
    local MiniFiles = require('mini.files')
    local show_dotfiles = false
    local filter_show = function()
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end
    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set(
          'n',
          'g.',
          toggle_dotfiles,
          { desc = 'Toggle hidden files', buffer = buf_id }
        )
      end,
    })

    -- Remember if we wanted to hide/show dotfiles after re-opening
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesExplorerOpen',
      callback = function()
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end,
    })
    require('mini.files').setup(opts)
  end,
}
