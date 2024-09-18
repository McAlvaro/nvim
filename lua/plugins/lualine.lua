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
			sections = {
				-- lualine_x = {
				-- "require('mcalvaro.laravel.artisan-server').status()"
				-- }
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					{
						require("mcalvaro.node.node-server").text,
						cond = function()
							return require("mcalvaro.node.node-server").running()
						end,
						color = { fg = "#00d75f", gui = "bold" },
					},
					{
						require("mcalvaro.laravel.artisan-server").text,
						cond = function()
							return require("mcalvaro.laravel.artisan-server").running()
						end,
						color = { fg = "#00d75f", gui = "bold" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
