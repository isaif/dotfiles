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
    {
      '<F2>',
      function()
        local MiniFiles = require('mini.files')
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end,
    },
  },
  -- opts = {
  --   windows = {
  --     preview = true,
  --   },
  -- },
  config = function(_, opts)
    -- toggle hidden files
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

    -- Open files in horizontal and vertical split
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local new_target_window
        vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
          vim.cmd(direction .. ' split')
          new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
        MiniFiles.go_in({})
        MiniFiles.close()
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak keys to your liking
        map_split(buf_id, '<C-x>', 'belowright horizontal')
        map_split(buf_id, '<C-v>', 'belowright vertical')
      end,
    })

    MiniFiles.setup(opts)
  end,
}
