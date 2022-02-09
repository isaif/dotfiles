local lsp_installer = require("nvim-lsp-installer")

local util = require 'lspconfig/util'
local root_pattern = util.root_pattern

-- function for mappings
local vimp = require('vimp')
local function nnoremap(...) vimp.nnoremap({'silent'}, ...) end
local bufmap = vimp.add_buffer_maps

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function common_on_attach(client, bufnr)

  --[[ set up buffer keymaps, etc.
  I think setting mappings here will only make this mappings available
  if lsp is enabled else the mappings will work as it is intended
  in vanilla vim
  for example 'gd' will use telescope if lsp is enabled else default
  'gd' mapping will be used ]]
  bufmap(bufnr, function()
    -- nnoremap({'silent'}, 'gd', ':Telescope lsp_definitions<cr>')
    nnoremap(',ld', ':Telescope lsp_document_symbols<CR>')
    nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    nnoremap('gd', ':Telescope lsp_definitions<cr>')
    nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    nnoremap('gr', ':Telescope lsp_refrences<CR>')
    nnoremap(',lt', ':Telescope lsp_type_definitions<CR>')
    nnoremap(',lr', '<cmd>lua vim.lsp.buf.rename()<CR>')
    nnoremap(',li', ':Telescope lsp_implementations<CR>')
    nnoremap(',ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    -- nnoremap(',lc', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    nnoremap(',lc', ':Telescope lsp_code_actions<CR>')
    nnoremap(',lm', '<cmd>lua vim.diagnostic.open_float()<CR>')
    nnoremap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    nnoremap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  end)
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities
  }
  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end

  if server.name == "tsserver" then
    -- opts.cmd = { "typescript-language-server", "--stdio"}
    -- opts.filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
    -- opts.init_options = {
    --   hostInfo = "neovim"
    -- }
    -- opts.root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")
    opts.on_attach = function(client, buffer)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      common_on_attach(client, buffer)
    end
  end


  if server.name == "sumneko_lua" then
    -- lspconfig's sumneko_lua by default provides .git or bufdir
    -- and the same settings are being used by nvim-lsp-installer
    -- https://github.com/williamboman/nvim-lsp-installer/blob/main/lua/nvim-lsp-installer/servers/sumneko_lua/init.lua
    -- in chezmoi folder it was using the chezmoi's .git as root
    -- now added .editorconfig in nvim directory to make it root
    -- if none of the options for root_dir match then lsp won't attach
    opts.root_dir =  root_pattern(".git", ".editorconfig")
    opts.settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  end

  -- if server.name == "null-ls" then
  --   print "null ls is alive"
  -- end

  server:setup(opts)
  -- server:setup(require("coq").lsp_ensure_capabilities(opts))
  vim.cmd [[ do User LspAttachBuffers ]]
end)

