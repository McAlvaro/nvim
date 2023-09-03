return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			indent = {
				enable = true,
				disable = { "python" },
			},
			ensure_installed = {
				"javascript", -- Agrega aqu√≠ los lenguajes que deseas mantener activos
				"html",
				"bash",
				"comment",
				"css",
				"csv",
				"dockerfile",
				"git_config",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"php",
				"phpdoc",
				"python",
				"scss",
				"sql",
				"tsx",
				"typescript",
				"vue",
				"xml",
				"yaml",
			},
		})
	end,
}
