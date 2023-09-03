return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        'williamboman/nvim-lsp-installer',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'ray-x/lsp_signature.nvim'

	},
	event = "VeryLazy",
    lazy = false,
	config = function()
		require("mcalvaro.mason")
	end,
}
