local lspkind = require("lspkind")
lspkind.init({
	symbol_map = {
		Supermaven = "",
		BladeNav = "",
	},
})

local luasnip = require("luasnip")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

cmp.setup({
	window = {
		--completion = cmp.config.window.bordered(),
		--documentation = cmp.config.window.bordered(),
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.close()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.choice_active() then
				luasnip.change_choice(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.choice_active() then
				luasnip.change_choice(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<c-space>"] = cmp.mapping.complete(),
	},
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "cmp-dbee" },
		{ name = "supermaven" },
		{
			name = "buffer",
			keyword_length = 5,
			option = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
			},
		},
	},

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
			},
		}),
	},

	experimental = {
		native_menu = false,

		ghost_text = true,
	},
})
-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- local lspconfig = require("lspconfig")
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
vim.lsp.config["emmet_ls"] = {
	capabilities = capabilities,
}

vim.lsp.enable("emmet_ls")

vim.lsp.config["intelephense"] = {
	capabilities = capabilities,
}
vim.lsp.enable("intelephense")

vim.lsp.config["lua_ls"] = {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				-- library = {
				--   [vim.fn.expand "$VIMRUNTIME/lua"] = true,
				--   [vim.fn.stdpath "config" .. "/lua"] = true,
				-- },
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

vim.lsp.enable("lua_ls")

-- vim.lsp.config["vtsls"] = {
-- 	filetypes = { "vue", "typescript", "javascript", "javascriptreact", "typescriptreact" },
-- 	capabilities = capabilities,
-- 	settings = {
-- 		vtsls = {
-- 			tsserver = {
-- 				globalPlugins = {
-- 					{
-- 						name = "@vue/typescript-plugin",
-- 						-- location = "/home/alvaro/.nvm/versions/node/v22.17.1/lib/node_modules/@vue/typescript-plugin",
-- 						location = vim.fn.stdpath("data")
-- 						.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
-- 						languages = { "typescript", "vue" },
-- 						configNamespace = "typescript",
-- 					},
-- 				},
-- 			},
-- 		},
-- 		typescript = {
-- 			inlayHints = {
-- 				enumMemberValues = {
-- 					enabled = true,
-- 				},
-- 				functionLikeReturnTypes = {
-- 					enabled = true,
-- 				},
-- 				parameterNames = { enabled = "all" },
-- 				parameterTypes = {
-- 					enabled = true,
-- 					suppressWhenArgumentMatchesName = true,
-- 				},
-- 				propertyDeclarationTypes = {
-- 					enabled = true,
-- 				},
-- 				variableTypes = {
-- 					enabled = true,
-- 				},
-- 			},
		-- },
	-- },
-- }

-- vim.lsp.enable("vtsls")

--vim.lsp.config["vue_ls"] = {

--	on_init = function(client)
--		client.handlers["tsserver/request"] = function(_, result, context)
--			local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
--			if #clients == 0 then
--				vim.notify(
--					"No se pudo encontrar el cliente lsp `vtsls` , `vue_ls` no funcionaría sin él.",
--					vim.log.levels.ERROR
--				)
--				return
--			end
--			local ts_client = clients[1]

--			local param = unpack(result)
--			local id, command, payload = unpack(param)
--			ts_client:exec_cmd({
--				title = "vue_request_forward", -- Puedes darle cualquier título ya que se usa para representar un comando en la interfaz de usuario, `:h Client:exec_cmd`
--				command = "typescript.tsserverRequest",
--				arguments = {
--					command,
--					payload,
--				},
--			}, { bufnr = context.bufnr }, function(_, r)
--				local response = r and r.body
--				-- TODO: manejar error o respuesta nula aquí, por ejemplo, registrar
--				-- NOTA: NO devolver si hay un error o no hay respuesta, solo devolver nil a vue_ls para evitar fugas de memoria
--				local response_data = { { id, response } }

--				---@diagnostic disable-next-line: param-type-mismatch
--				client:notify("tsserver/response", response_data)
--			end)
--		end
--	end,
--	capabilities = capabilities,
--}

--vim.lsp.enable("vue_ls")

--local Group = require("colorbuddy.group").Group
-- local g = require("colorbuddy.group").groups
-- local s = require("colorbuddy.style").styles

-- Group.new("CmpItemAbbr", g.Comment)
-- Group.new("CmpItemAbbrDeprecated", g.Error)
-- Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
-- Group.new("CmpItemKind", g.Special)
-- Group.new("CmpItemMenu", g.NonText)
vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#6CC644" })
