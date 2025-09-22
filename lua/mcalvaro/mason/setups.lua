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
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		return {
			on_attach = lsp_attach,
			flags = lsp_flags,
			filetypes = { "php", "cucumber" },
			-- capabilities = capabilities,
			-- cmd = { "phpactor", "language-server" },
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
	ts_ls = function()
		return {
			on_attach = lsp_attach,
			flags = lsp_flags,
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/home/alvaro/.nvm/versions/node/v22.17.1/lib/node_modules/@vue/typescript-plugin",
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

        local get_install_path = function (name)
            return vim.fn.expand("$MASON/packages/" .. name)
        end

		-- local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
		local jdtls_path = get_install_path("jdtls")
		-- local java_debug_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()
		local java_debug_path = get_install_path("java-debug-adapter")
		-- local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()
		local java_test_path = get_install_path("java-test")

		local bundles = {
			vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
		}

		vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))

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
			root_dir = vim.fs.root(0, {'gradlew', '.git', 'mvnw'}),
			-- root_dir = require("lspconfig.configs.jdtls").default_config.root_dir,
			-- root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
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
								path = "/usr/lib/jvm/java-1.21.0-openjdk-amd64", -- Java Installation
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
						enabled = true,
					},
				},
				signatureHelp = { enabled = true },
			},
			init_options = {
				-- bundles = {
				-- java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
				-- vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
				-- vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1),
				-- },
				bundles = bundles,
			},
			on_attach = function(client, bufnr)
				local _, _ = pcall(vim.lsp.codelens.refresh)
				require("jdtls.dap").setup_dap({ hotcodereplace = "auto" })
				-- require("vim.lsp").on_attach(client, bufnr)
				require("jdtls.dap").setup_dap_main_class_configs()
				-- lsp_attach(client, bufnr)
				return lsp_attach
			end,
		}
	end,
	pyright = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		return {
			on_attach = lsp_attach,
			flags = lsp_flags,
			capabilities = capabilities,
			filetypes = { "python" },
		}
	end,
	html = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		return {
			capabilities = capabilities,
			filetypes = { "html", "blade" },
			init_options = {
				configurationSection = { "html", "css", "javascript" },
				embeddedLanguages = {
					css = true,
					javascript = true,
				},
				provideFormatter = true,
			},
		}
	end,
	vtsls = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		return {
			filetypes = { "vue", "typescript", "javascript", "javascriptreact", "typescriptreact" },
			capabilities = capabilities,
			settings = {
				vtsls = {
					tsserver = {
						globalPlugins = {
							{
								name = "@vue/typescript-plugin",
								-- location = "/home/alvaro/.nvm/versions/node/v22.17.1/lib/node_modules/@vue/typescript-plugin",
								location = vim.fn.stdpath("data")
									.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
								languages = { "typescript", "vue" },
								configNamespace = "typescript",
							},
						},
					},
				},
				typescript = {
					inlayHints = {
						enumMemberValues = {
							enabled = true,
						},
						functionLikeReturnTypes = {
							enabled = true,
						},
						parameterNames = { enabled = "all" },
						parameterTypes = {
							enabled = true,
							suppressWhenArgumentMatchesName = true,
						},
						propertyDeclarationTypes = {
							enabled = true,
						},
						variableTypes = {
							enabled = true,
						},
					},
				},
			},
		}
	end,
	vue_ls = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		return {
			capabilities = capabilities,
			on_init = function(client)
				client.handlers["tsserver/request"] = function(_, result, context)
					local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
					if #clients == 0 then
						vim.notify(
							"No se pudo encontrar el cliente lsp `vtsls` , `vue_ls` no funcionaría sin él.",
							vim.log.levels.ERROR
						)
						return
					end
					local ts_client = clients[1]

					local param = unpack(result)
					local id, command, payload = unpack(param)
					ts_client:exec_cmd({
						title = "vue_request_forward", -- Puedes darle cualquier título ya que se usa para representar un comando en la interfaz de usuario, `:h Client:exec_cmd`
						command = "typescript.tsserverRequest",
						arguments = {
							command,
							payload,
						},
					}, { bufnr = context.bufnr }, function(_, r)
						local response = r and r.body
						-- TODO: manejar error o respuesta nula aquí, por ejemplo, registrar
						-- NOTA: NO devolver si hay un error o no hay respuesta, solo devolver nil a vue_ls para evitar fugas de memoria
						local response_data = { { id, response } }

						---@diagnostic disable-next-line: param-type-mismatch
						client:notify("tsserver/response", response_data)
					end)
				end
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
