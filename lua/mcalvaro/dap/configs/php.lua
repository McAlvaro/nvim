local dap = require("dap")

local get_install_path = function(name)
	return vim.fn.expand("$MASON/packages/" .. name)
end

dap.adapters.php = {
	type = "executable",
	command = "node",
	args = {
		get_install_path("php-debug-adapter") .. "/extension/out/phpDebug.js",
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
