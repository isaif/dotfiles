return {
  'echasnovski/mini.ai',
  event = 'CursorHold',
  -- keymaps = {},
  dependencies = {
    -- Support for tree-sitter specifications via exported MiniAI.gen_spec.treesitter() function.
    -- In order for this to work, user should have 'textobjects' query files with specified captures for every target language.
    -- Can have them either by just installing 'nvim-treesitter/nvim-treesitter-textobjects' (but not enabling textobjects) or creating manually inside 'after/queries/<language>/textobjects.scm' files.
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    local gen_spec = require('mini.ai').gen_spec
    local spec_treesitter = gen_spec.treesitter

    require('mini.ai').setup({
      custom_textobjects = {
        F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
        o = spec_treesitter({
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }),

        -- current line textobject
        e = function(ai_type)
          -- Get the current line
          local line = vim.fn.line('.')

          -- Get the line text
          local line_text = vim.fn.getline(line)

          -- Find the first non-blank character
          local first_non_blank = line_text:find('%S')
          -- local line_end = line_text:find('$')
          -- local line_end = line_text:find('\n')

          -- Create the region for the 'i' variant
          -- from first non-blank character to last character - 1
          -- useful to yank line without ; , etc
          -- Y can copy from cursor to end of line without new line character
          local i_region = {
            from = { line = line, col = first_non_blank },
            to = { line = line, col = #line_text - 1 },
          }

          -- Create the region for the 'a' variant
          -- from first non-blank character to last character
          -- TODO: include carriage return
          -- Y can copy from cursor to end of line without new line character
          local a_region = {
            -- from = { line = line, col = 1 },
            from = { line = line, col = first_non_blank },
            -- to = { line = line, col = line_end },
            to = { line = line, col = #line_text },
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
