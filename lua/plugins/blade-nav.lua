return {
	"ricardoramirezr/blade-nav.nvim",
	dependencies = { -- totally optional
		"hrsh7th/nvim-cmp", -- if using nvim-cmp
		-- { "ms-jpq/coq_nvim", branch = "coq" }, -- if using coq
		-- "saghen/blink.cmp", -- if using blink.cmp
	},
	ft = { "blade", "php" }, -- optional, improves startup time
	opts = {
		-- This applies for nvim-cmp and coq, for blink refer to the configuration of this plugin
		close_tag_on_complete = false, -- default: true
	},
}
