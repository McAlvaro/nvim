return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<A-l>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-l>",
			},
			disable_inline_completion = true,
			disable_keymaps = true,
            ignore_filetypes = { markdown = true, ["copilot-chat"] = true },
		})
	end,
}
