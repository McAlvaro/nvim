return {
	"McAlvaro/startup.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    lazy = false,
    enabled = true,
	config = function()
		require("startup").setup()
	end,
}

