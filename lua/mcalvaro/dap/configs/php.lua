local dap = require("dap")

dap.adapters.php = {
	type = "executable",
	command = "node",
	args = {
		require("mason-registry").get_package("php-debug-adapter"):get_install_path() .. "/extension/out/phpDebug.js",
	},
}

dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Laravel",
		port = 9003,
		pathMappings = {
			["/var/www/app"] = "${workspaceFolder}",
		},
	},
	{
		type = "php",
		request = "launch",
		name = "Symfony",
		port = 9003,
		pathMappings = {
			["/app"] = "${workspaceFolder}",
		},
	},
	{
		name = "Launch currently open script",
		type = "php",
		request = "launch",
		program = "${file}",
		port = 9003,
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
	},
}
