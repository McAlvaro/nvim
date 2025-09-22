return {
	"mason-org/mason.nvim",
    -- version = "1.11.0",
	dependencies = {
		{
            "mason-org/mason-lspconfig.nvim",
            -- version = "1.32.0"
        },
		"neovim/nvim-lspconfig",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
        "nvimtools/none-ls.nvim",
        -- 'williamboman/nvim-lsp-installer',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'ray-x/lsp_signature.nvim'

	},
	event = "VeryLazy",
    lazy = false,
	config = function()
		require("mcalvaro.mason")
	end,
}
