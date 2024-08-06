-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   -- autocmd BufNewFile, BufRead *.bicep set filetype=bicep
--   capabilities = capabilities
-- }

lspconfig.ansiblels.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities
})


vim.cmd([[ autocmd BufNewFile,BufRead *.bicep set filetype=bicep ]])

lspconfig.bicep.setup {}

local bicep_lsp_bin =
"/home/ramboe/.local/share/nvim/mason/packages/bicep-lsp/extension/bicepLanguageServer/Bicep.LangServer.dll"

lspconfig.bicep.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "dotnet", bicep_lsp_bin },
  filetypes = { "bicep" }
})


--
lspconfig.dockerls.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "Dockerfile" }
})

lspconfig.csharp_ls.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "csharp-ls" },
  filetypes = { "cs" }
})
--
--
-- local pid = vim.fn.getpid()

-- lspconfig.omnisharp.setup({
--   cmd = { "omnisharp-mono", "--languageserver", "--hostPID", tostring(pid) },
--   filetypes = {"cs"}
-- })

-- lspconfig.omnisharp.setup({
--     on_attach = on_attach,
--   on_init = on_init,
--     capabilities = capabilities,
--     -- cmd = { omnisharp_server_location, "--languageserver" , "--hostPID", tostring(pid) },
--  })

lspconfig.tsserver.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = false
    }
  }
})

lspconfig.eslint.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  --- ...
  -- on_attach = function(client, bufnr)
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     buffer = bufnr,
  --     command = "EslintFixAll",
  --   })
  -- end,
})
