return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"SmiteshP/nvim-navbuddy",
			dependencies = {
				"SmiteshP/nvim-navic",
				"MunifTanjim/nui.nvim",
			},
			opts = { lsp = { auto_attach = true } },
		},
		"numToStr/Comment.nvim", -- Optional
		"nvim-telescope/telescope.nvim", -- Optional
	},
	-- your lsp config or other stuff
    config = function ()
        require("mcalvaro.navbuddy.setup")
    end,
    cmd = { "Navbuddy" }

}
