local settings = {
  settings = {
    gopls = {
      staticcheck = true,
    },
  },
}

local M = {}

M.setup = function(on_attach, capabilities)
  require('lspconfig').gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings,
  })
end

return M
