local settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      -- other projects settings will have it's own config
      -- the config wil be loaded by neoconf.nvim plugins
      version = 'LuaJIT',
      -- Setup your lua path
      path = vim.split(package.path, ';')
    },
    diagnostics = {
      globals = {
        -- "use",
        -- "describe",
        -- "it",
        -- "assert",
        -- "before_each",
        -- "after_each",

        -- awesomewm has following as binary therefore need to add globals
        -- 'awesome',
        -- 'client',
      },
    },
    completion = {
      showWord = 'Disable',
      callSnippet = 'Disable',
      keywordSnippet = 'Disable',
    },
    workspace = {
      -- It will be useful to have this option for other projects
      -- therefore not disable globally
      -- checkThirdParty = false,

      -- library = vim.api.nvim_get_runtime_file('', true),
      library = {
        -- ["${3rd}/love2d/library"] = true,

        -- ['/usr/share/nvim/runtime/lua'] = true,
        -- ['/usr/share/nvim/runtime/lua/lsp'] = true,

        -- awesomewm
        -- ['/usr/share/awesome/lib'] = true,
      }
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
