local get_install_path = function(name)
	return vim.fn.expand("$MASON/packages/" .. name)
end

require("dap").adapters.node2 = {
	type = "executable",
	command = "node",
	args = {
		get_install_path("node-debug2-adapter") .. "/out/src/nodeDebug.js",
	},
}

require("dap").adapters.firefox = {
	type = "executable",
	command = "node",
	args = {
		get_install_path("firefox-debug-adapter") .. "/dist/adapter.bundle.js",
	},
}

for _, language in pairs({ "javascript", "typescript" }) do
	require("dap").configurations[language] = {
		{
			name = "Launch Node against current file",
			type = "node2",
			request = "launch",
			program = "${file}",
			-- cwd = vim.uv.cwd(),
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			name = "Launch Node against pick process",
			type = "node2",
			request = "attach",
			processId = require("dap.utils").pick_process,
			console = "integratedTerminal",
		},
		{
			name = "Launch Firefox against localhost",
			request = "launch",
			type = "firefox",
			reAttach = true,
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			console = "integratedTerminal",
		},
	}
end

for _, language in pairs({ "javascriptreact", "typescriptreact" }) do
	require("dap").configurations[language] = {
		{
			name = "Launch Firefox against localhost",
			request = "launch",
			type = "firefox",
			reAttach = true,
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			console = "integratedTerminal",
		},
	}
end
