local settings = {
  Lua = {
    -- runtime = {
    --   -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
    --   version = 'LuaJIT',
    --   -- Setup your lua path
    -- },
    diagnostics = {
      globals = {
        'vim',
        -- "use",
        -- "describe",
        -- "it",
        -- "assert",
        -- "before_each",
        -- "after_each",
      },
    },
    completion = {
      showWord = 'Disable',
      callSnippet = 'Disable',
      keywordSnippet = 'Disable',
    },
    workspace = {
      checkThirdParty = false,
      -- library = {
      --     ["${3rd}/love2d/library"] = true,
      -- },
      library = vim.api.nvim_get_runtime_file('', true),
    },
    telemetry = {
      enable = false,
    },
  },
}

local M = {}

M.setup = function(on_attach, capabilities)
  require('lspconfig').lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings,
  })
end

return M
