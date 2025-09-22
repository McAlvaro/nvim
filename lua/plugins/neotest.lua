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
					phpunit_cmd = function()
						return "vendor/bin/phpunit" -- for `dap` strategy then it must return string (table values will cause validation error)
					end,
					root_files = { "composer.json", "phpunit.xml", ".gitignore" },
					filter_dirs = { ".git", "node_modules", "vendor" },
					env = {}, -- for example {XDEBUG_CONFIG = 'idekey=neotest'}
					dap = nil, -- to configure `dap` strategy put single element from `dap.configurations.php`
				}),
				require("neotest-java"),
				require("neotest-python")({
					-- Extra arguments for nvim-dap configuration
					-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
					dap = { justMyCode = false },
					-- Command line arguments for runner
					-- Can also be a function to return dynamic values
					args = { "--log-level", "DEBUG" },
					-- Runner to use. Will use pytest if available by default.
					-- Can be a function to return dynamic value.
					runner = "pytest",
					-- Custom python path for the runner.
					-- Can be a string or a list of strings.
					-- Can also be a function to return dynamic value.
					-- If not provided, the path will be inferred by checking for
					-- virtual envs in the local directory and for Pipenev/Poetry configs
					python = ".venv/bin/python3",
					-- Returns if a given file path is a test file.
					-- NB: This function is called a lot so don't perform any heavy tasks within it.
					-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
					-- instances for files containing a parametrize mark (default: false)
					pytest_discover_instances = true,
					-- is_test_file = function(file_path)
					-- 	return file_path:match("test_.+%.py") ~= nil or file_path:match("_test%.py") ~= nil
					-- end,
				}),
				require("neotest-vim-test")({
					filter_dirs = { "vendor" },
					ignore_file_types = { "go", "lua", "rust", "php" },
				}),
				-- require("laravel.neotest"),
			},
			-- overseer.nvim
			consumers = {
				-- overseer = require("neotest.consumers.overseer"),
				-- neotest_consumers = require("neotest-consumers").consumers
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
			foreign_keys = "warn",
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
