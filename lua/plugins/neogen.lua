return {
	"danymat/neogen",
	cmd = "Neogen",
	keys = {
		{
			"<leader>cn",
			function()
				require("neogen").generate()
			end,
			desc = "Generate Annotations (Neogen)",
		},
	},
	opts = function(_, opts)
		if opts.snippet_engine ~= nil then
			return
		end

		local map = {
			["LuaSnip"] = "luasnip",
			["nvim-snippy"] = "snippy",
			["vim-vsnip"] = "vsnip",
		}


		for plugin, engine in pairs(map) do
            local plugins = vim.fn.globpath(vim.fn.stdpath("data") .. "/lazy", plugin, 0, 1)
			if #plugins>0 then
				opts.snippet_engine = engine
				return
			end
		end

		if vim.snippet then
			opts.snippet_engine = "nvim"
		end
	end,
	config = function()
		require("neogen").setup({})
	end,
}
