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
	jdtls = function()
		-- Setup Workspace
		local home = os.getenv("HOME")
		local workspace_path = home .. "/.local/share/nvim/jdtls_workspace/"
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = workspace_path .. project_name

		local os_config = "linux"
		if vim.fn.has("mac") == 1 then
			os_config = "mac"
		end

		local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
		local java_debug_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()
		local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()

		return {
			filetypes = {
				"java",
			},
			cmd = {
				"/usr/lib/jvm/java-1.21.0-openjdk-amd64/bin/java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xms1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-javaagent:" .. jdtls_path .. "/lombok.jar",
				"-jar",
				vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
				"-configuration",
				jdtls_path .. "/config_" .. os_config,
				"-data",
				workspace_dir,
			},
			root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,
			settings = {
				java = {
					eclipse = {
						downloadSources = true,
					},
					configuration = {
						updateBuildConfiguration = "interactive",
						runtimes = {
							{
								name = "JavaSE-21",
								path = "/usr/lib/jvm/java-1.21.0-openjdk-amd64",
							},
						},
					},
					maven = {
						downloadSources = true,
					},
					implementationsCodeLens = {
						enabled = true,
					},
					referencesCodeLens = {
						enabled = true,
					},
					references = {
						includeDecompiledSources = true,
					},
					inlayHints = {
						parameterNames = {
							enabled = "all", -- literals, all, none
						},
					},
					format = {
						enabled = false,
					},
				},
				signatureHelp = { enabled = true },
			},
			init_options = {
				bundles = {
					java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-0.50.0.jar",
					vim.fn.glob(java_test_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
				},
			},
			on_attach = function(client, bufnr)
				local _, _ = pcall(vim.lsp.codelens.refresh)
				require("jdtls.dap").setup_dap({ hotcodereplace = "auto" })
				require("jdtls.dap").setup_dap_main_class_configs()
				require("vim.lsp").on_attach(client, bufnr)
				-- local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
				-- if status_ok then
				-- jdtls_dap.setup_dap_main_class_configs()
				-- end
			end,
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
