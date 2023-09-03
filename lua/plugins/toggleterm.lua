return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = true,
	config = function()
		require("toggleterm").setup({})
	end,
	cmd = {
		"ToggleTerm",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualLines",
		"ToggleTermSendVisualSelection",
		"ToggleTermSetName",
		"ToggleTermToggleAll",
	},
}
