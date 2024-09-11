local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

-- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
return {
  'kevinhwang91/nvim-ufo',
  disable = false,
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    vim.o.foldcolumn = '0' -- disable foldcolumn
    vim.wo.foldlevel = 99 -- feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.wo.foldenable = true

    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)
    vim.keymap.set('n', 'zp', require('ufo').peekFoldedLinesUnderCursor)

    -- if IsAvailable('lspconfig') then
    --     -- option 2: nvim lsp as LSP client
    --     -- tell the server the capability of foldingRange
    --     -- nvim hasn't added foldingRange to default capabilities, users must add it manually
    --     local capabilities = vim.lsp.protocol.make_client_capabilities()
    --     capabilities.textDocument.foldingRange = {
    --         dynamicRegistration = false,
    --         lineFoldingOnly = true
    --     }
    --     -- local language_servers = {'ccls'} -- like {'gopls', 'clangd'}
    --     local language_servers = {} -- like {'gopls', 'clangd'}
    --     for _, ls in ipairs(language_servers) do
    --         require('lspconfig')[ls].setup({
    --             capabilities = capabilities,
    --             -- other_fields = ...
    --         })
    --     end
    -- end

    require('ufo').setup({
      open_fold_hl_timeout = 50,
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,

      fold_virt_text_handler = handler,
    })

    -- buffer scope handler
    -- will override global handler if it is existed
    local bufnr = vim.api.nvim_get_current_buf()
    require('ufo').setFoldVirtTextHandler(bufnr, handler)
  end,
}
