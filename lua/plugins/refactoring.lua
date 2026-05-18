return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup()
	end,
	keys = {
		{
			"<leader>vca",
			function()
				require("refactoring").select_refactor()
			end,
			mode = "v",
			desc = "Refactor",
		},
	},
}
