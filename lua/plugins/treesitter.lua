return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "php" }, -- Reemplazamos <filetype> por 'php'
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
	opts = {
		ensure_installed = {
			"javascript", -- Agrega aquí los lenguajes que deseas mantener activos
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
	},
}
