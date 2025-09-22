-- LSP configuration

-- install servers and tools
require("mcalvaro.mason.mason")
local setups = require("mcalvaro.mason.setups")

-- local lspconfig = require('lspconfig')
-- require("mason-lspconfig").setup({
-- 	handlers = function(server_name)
-- 		vim.lsp.config[server_name] = setups[server_name]()
-- 		vim.lsp.enable(server_name)
-- 	end,
-- })

for server_name, setup_fn in pairs(setups) do
	vim.lsp.config[server_name] = setup_fn()
	vim.lsp.enable(server_name)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 2, prefix = "●" },
	severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

require("mcalvaro.mason.null-ls")
