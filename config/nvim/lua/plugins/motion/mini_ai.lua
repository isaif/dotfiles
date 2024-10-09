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
        f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
        o = spec_treesitter({
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }),
        c = spec_treesitter({ a = '@class.outer', i = '@class.inner' }), -- class

        u = gen_spec.function_call(), -- u for "Usage", remapped from 'f' to 'u'
        U = gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name

        e = { -- Word with case
          {
            '%u[%l%d]+%f[^%l%d]',
            '%f[%S][%l%d]+%f[^%l%d]',
            '%f[%P][%l%d]+%f[^%l%d]',
            '^[%l%d]+%f[^%l%d]',
          },
          '^().*()$',
        },

        d = { '%f[%d]%d+' }, -- digits

        -- current line textobject
        s = function(ai_type)
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

        -- Mini.ai indent text object
        -- For "a", it will include the non-whitespace line surrounding the indent block.
        -- "a" is line-wise, "i" is character-wise.
        i = function(ai_type)
          local spaces = (' '):rep(vim.o.tabstop)
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          local indents = {} ---@type {line: number, indent: number, text: string}[]

          for l, line in ipairs(lines) do
            if not line:find('^%s*$') then
              indents[#indents + 1] = {
                line = l,
                indent = #line:gsub('\t', spaces):match('^%s*'),
                text = line,
              }
            end
          end

          local ret = {} ---@type (Mini.ai.region | {indent: number})[]

          for i = 1, #indents do
            if i == 1 or indents[i - 1].indent < indents[i].indent then
              local from, to = i, i
              for j = i + 1, #indents do
                if indents[j].indent < indents[i].indent then
                  break
                end
                to = j
              end
              from = ai_type == 'a' and from > 1 and from - 1 or from
              to = ai_type == 'a' and to < #indents and to + 1 or to
              ret[#ret + 1] = {
                indent = indents[i].indent,
                from = {
                  line = indents[from].line,
                  col = ai_type == 'a' and 1 or indents[from].indent + 1,
                },
                to = { line = indents[to].line, col = #indents[to].text },
              }
            end
          end

          return ret
        end,
      },
    })
  end,
}
