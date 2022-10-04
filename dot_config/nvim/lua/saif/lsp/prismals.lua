local M = {}

-- local settings = {
--   prisma = {}
-- }

M.setup = function(on_attach, capabilities)
  require('lspconfig').prismals.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
