return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	priority = 1000,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local horizon_custom = require("lualine.themes.horizon")

		horizon_custom.normal.a.bg = "#06989a"
		horizon_custom.insert.a.bg = "#00d75f"

		require("lualine").setup({
			options = {
				theme = horizon_custom,
				icons_enabled = true,
			},
		})
	end,
}
