return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-go",
		"rouge8/neotest-rust",
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/neotest-vim-test",
		"nvim-neotest/neotest-python",
		-- "anuvyklack/hydra.nvim",
		"nvimtools/hydra.nvim",
		"olimorris/neotest-phpunit",
		"rcasia/neotest-java",
		-- "thenbe/neotest-consumers"
	},
	keys = {
		{ "<leader>er", desc = "Open Test menu" },
	},

	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-go"),
				require("neotest-rust"),
				require("neotest-plenary"),
				require("neotest-phpunit")({
					filter_dirs = { "vendor" },
				}),
				require("neotest-java"),
				require("neotest-vim-test")({
					filter_dirs = { "vendor" },
					ignore_file_types = { "go", "lua", "rust", "php" },
				}),
				-- require("laravel.neotest"),
			},
			overseer = {
				enabled = true,
				force_default = true,
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
					type = "window",
					position = "bottom",
					float_opts = {
                        border = "rounded",
						style = "minimal",
						focusable = false,
						noautocmd = true,
					},
				},
			},
			body = "<leader>er",
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
