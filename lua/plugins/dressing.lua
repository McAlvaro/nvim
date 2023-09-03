return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	config = function()
		require("dressing").setup({
			input = { relative = "editor" },
			backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
		})
	end,
}
