local lspconfig = require("lspconfig")

-- Aliases for easier calling.
local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

-- Provides LSP-based auto-import
lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    local ts_utils = require("nvim-lsp-ts-utils")

    ts_utils.setup({})
    ts_utils.setup_client(client)

    buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
    buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
    buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
  end,
})

-- Apparently null-ls is a must-have with the tsserver stuff, so I've installed
-- it ¯\_(ツ)_/¯
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- Note we use eslint_d as a daemonised eslint, which returns errors
    -- faster
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettier
  },
  on_attach = on_attach
})
