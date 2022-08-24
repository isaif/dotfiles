-- This is Comment.nvim not nvim-comment
-- need to change the filename

-- Setup for Comment.nvim
require('Comment').setup({
  -- Comment.nvim has no jsx-tsx support
  -- therefore using nvim-ts-context-commentstring
  -- Both commentstring repo and Comment repo has example integration code
  -- but Comment recommends to use its version

  ---@param ctx Ctx
  pre_hook = function(ctx)
    -- Only calculate commentstring for tsx filetypes
    -- I have added javascriptreact as I need it
    if vim.bo.filetype == 'typescriptreact' or 'javascriptreact' then
      local U = require('Comment.utils')

      -- Detemine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.linewise and '__default'
        or '__multiline'

      -- Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.blockwise then
        location =
          require('ts_context_commentstring.utils').get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location =
          require('ts_context_commentstring.utils').get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring({
        key = type,
        location = location,
      })
    end
  end,
})
