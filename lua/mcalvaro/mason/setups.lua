local lsp_attach = require("mcalvaro.mason.attach")

local lsp_flags = {
	debounce_text_changes = 150,
}

return setmetatable({
	rust_analyzer = function()
		return {
			on_attach = lsp_attach,
			flags = lsp_flags,
			settings = {
				["rust-analyzer"] = {},
			},
		}
	end,
	phpactor = function()
		return {
			on_attach = lsp_attach,
			flags = lsp_flags,
			filetypes = { "php", "cucumber" },
		}
	end,
	emmet_ls = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		return {
			on_attach = lsp_attach,
			flags = lsp_flags,
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "blade" },
		}
	end,
	sumneko_lua = function()
		return {
			on_attach = lsp_attach,
			flags = lsp_flags,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}
	end,
	tsserver = function()
		return {
			on_attach = lsp_attach,
			flags = lsp_flags,
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/home/alvaro/.nvm/versions/node/v20.9.0/lib/node_modules/@vue/typescript-plugin",
						languages = { "typescript", "vue" },
					},
				},
			},
			filetypes = {
				"javascript",
				"typescript",
				"vue",
			},
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		}
	end,
}, {
	__index = function()
		return function()
			return {
				on_attach = lsp_attach,
				flags = lsp_flags,
			}
		end
	end,
})
