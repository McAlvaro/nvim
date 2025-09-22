return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			-- lua = { "stylua" },
			-- python = { "isort", "black" },
			python = { "autopep8" },
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
			json = { "jq" },
		},
	},
}
