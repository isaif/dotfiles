return {
  'echasnovski/mini.ai',
  event = 'CursorHold',
  dependencies = {
    -- required for treesitter custom_textobjects to work
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    local spec_treesitter = require('mini.ai').gen_spec.treesitter

    require('mini.ai').setup({
      custom_textobjects = {
        F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
        o = spec_treesitter({
          a = { '@conditional.outer', '@loop.outer' },
          i = { '@conditional.inner', '@loop.inner' },
        }),

        -- Whole buffer
        -- my implementation ig and ag are same
        -- g = function()
        --   local from = { line = 1, col = 1 }
        --   local to = {
        --     line = vim.fn.line('$'),
        --     col = math.max(vim.fn.getline('$'):len(), 1),
        --   }
        --   return { from = from, to = to }
        -- end,

        -- Whole buffer
        -- selects everything not including blank lines
        -- at start and end of buffer, aB - with them.
        g = function(ai_type)
          local n_lines = vim.fn.line('$')
          local start_line, end_line = 1, n_lines
          if ai_type == 'i' then
            -- Skip first and last blank lines for `i` textobject
            local first_nonblank, last_nonblank =
              vim.fn.nextnonblank(1), vim.fn.prevnonblank(n_lines)
            start_line = first_nonblank == 0 and 1 or first_nonblank
            end_line = last_nonblank == 0 and n_lines or last_nonblank
          end

          local to_col = math.max(vim.fn.getline(end_line):len(), 1)
          return {
            from = { line = start_line, col = 1 },
            to = { line = end_line, col = to_col },
          }
        end,

        -- current line
        e = function(ai_type)
          -- Get the current line
          local line = vim.fn.line('.')

          -- Get the line text
          local line_text = vim.fn.getline(line)

          -- Find the first non-blank character
          local first_non_blank = line_text:find('%S')
          local line_end = line_text:find('$')

          -- Create the region for the 'i' variant
          local i_region = {
            from = { line = line, col = first_non_blank },
            to = { line = line, col = #line_text },
          }

          -- Create the region for the 'a' variant
          local a_region = {
            from = { line = line, col = 1 },
            to = { line = line, col = line_end },
          }

          -- Return the appropriate region based on the ai_type
          if ai_type == 'a' then
            return a_region
          else
            return i_region
          end
        end,
      },
    })
  end,
}
