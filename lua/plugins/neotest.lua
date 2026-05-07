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

		local function has_root_file(files)
			local cwd = vim.fn.getcwd()
			for _, file in ipairs(files) do
				if vim.loop.fs_stat(cwd .. "/" .. file) then
					return true
				end
			end
			return false
		end

		local adapters = {
			require("neotest-plenary"),
		}

		-- 🐘 PHP
		if has_root_file({ "composer.json", "phpunit.xml", "pest.php" }) then
			table.insert(
				adapters,
				require("neotest-phpunit")({
					phpunit_cmd = function()
						return "vendor/bin/phpunit"
					end,
					root_files = { "composer.json", "phpunit.xml", ".gitignore" },
					filter_dirs = { ".git", "node_modules", "vendor" },
					env = {},
					dap = nil,
				})
			)
		end

		-- ☕ Java
		if has_root_file({ "pom.xml", "build.gradle", ".project" }) then
			table.insert(adapters, require("neotest-java"))
		end

		-- 🐹 Go
		if has_root_file({ "go.mod" }) then
			table.insert(adapters, require("neotest-go"))
		end

		-- 🦀 Rust
		if has_root_file({ "Cargo.toml" }) then
			table.insert(adapters, require("neotest-rust"))
		end

		-- 🐍 Python
		if has_root_file({ "requirements.txt", "pyproject.toml", "setup.py", "manage.py" }) then
			table.insert(
				adapters,
				require("neotest-python")({
					dap = { justMyCode = false },
					args = { "--log-level", "DEBUG" },
					runner = "pytest",
					python = ".venv/bin/python3",
					pytest_discover_instances = true,
				})
			)
		end

		-- 🏁 Fallback / Generic
		table.insert(
			adapters,
			require("neotest-vim-test")({
				filter_dirs = { "vendor" },
				ignore_file_types = { "go", "lua", "rust", "php" },
			})
		)

		neotest.setup({
			adapters = adapters,
			-- overseer.nvim
			consumers = {},
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
