return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-go",
		"rouge8/neotest-rust",
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/neotest-vim-test",
		"anuvyklack/hydra.nvim",
		"olimorris/neotest-phpunit",
	},
	keys = {
		{ "<leader>nm", desc = "Open Test menu" },
	},

	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-go"),
				require("neotest-rust"),
				require("neotest-plenary"),
				require("neotest-phpunit"),
				require("neotest-vim-test")({
                    filter_dirs = { "vendor" },
					ignore_file_types = { "go", "lua", "rust", "php" },
				}),
				-- require("laravel.neotest"),
			},
		})

		local hydra = require("hydra")

		local hint = [[
         NeoTest
         _n_: Near test _f_: Current file _l_: Last Test  ^
         _d_: Test Directory  ^
         _w_: Test Watch Directory  ^
         _m_: Run Marked  ^
         _s_: Toggle Summary ^
         ^ ^                                            _<Esc>_
        ]]

		hydra({
			name = "neotest",
			hint = hint,
			mode = "n",
			config = {
				color = "teal",
				invoke_on_body = true,
				hint = {
					border = "rounded",
					position = "bottom",
				},
			},
			body = "<leader>nm",
			heads = {
				{
					"n",
					function()
						neotest.run.run()
						neotest.summary.open()
					end,
				},
				{
					"f",
					function()
						neotest.run.run(vim.fn.expand("%"))
						neotest.summary.open()
					end,
				},
				{ "l", neotest.run.run_last },
				{ "m", neotest.summary.run_marked },
				{ "s", neotest.summary.toggle },
				{
					"d",
					function()
						neotest.run.run("tests")
						neotest.summary.open()
					end,
				},
				{
					"w",
					function()
						neotest.watch.toggle("tests")
						neotest.summary.open()
					end,
				},
				{ "<Esc>", nil, { exit = true } },
			},
		})
	end,
}
