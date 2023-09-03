vim.cmd('packadd nvim-dap')
local dap, dapui, hydra = require "dap", require "dapui", require "hydra"

-- Set Icons
vim.api.nvim_call_function(
	"sign_define",
	{ "DapBreakpoint", { linehl = "", text = "", texthl = "diffRemoved", numhl = "" } }
)

vim.api.nvim_call_function(
	"sign_define",
	{ "DapBreakpointCondition", { linehl = "", text = "", texthl = "diffRemoved", numhl = "" } }
)

vim.api.nvim_call_function(
	"sign_define",
	{ "DapLogPoint", { linehl = "", text = "", texthl = "diffRemoved", numhl = "" } }
)

vim.api.nvim_call_function(
	"sign_define",
	{ "DapStopped", { linehl = "GitSignsChangeVirtLn", text = "", texthl = "diffChanged", numhl = "" } }
)

vim.api.nvim_call_function(
	"sign_define",
	{ "DapBreakpointRejected", { linehl = "", text = "", texthl = "", numhl = "" } }
)


-- Setup Virtual Text
require("nvim-dap-virtual-text").setup {}

-- Setup DAPUI
dapui.setup({
  icons = { collapsed = "", current_frame = "", expanded = "" },
  layouts = {
    {
      elements = { "scopes", "watches", "stacks", "breakpoints" },
      size = 80,
      position = "left",
    },
    { elements = { "console", "repl" }, size = 0.25, position = "bottom" },
  },
  render = { indent = 2 },
})


-- Load Confgis for languages
for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/mcalvaro/dap/configs/*.lua", true)) do
  loadfile(ft_path)()
end



dap.listeners.after.event_initialized['dapui_config'] = function()
	dapui.open()

end

local hint = [[
 Nvim DAP
 _d_: Start/Continue  _j_: StepOver _k_: StepOut _l_: StepInto ^
 _bp_: Toogle Breakpoint  _bc_: Conditional Breakpoint ^
 _?_: log point ^
 _c_: Run To Cursor ^
 _h_: Show information of the variable under the cursor ^
 _x_: Stop Debbuging ^
 ^^                                                      _<Esc>_
]]


hydra {
  name = "dap",
  hint = hint,
  mode = "n",
  config = {
    color = "blue",
    invoke_on_body = true,
    hint = {
      border = "rounded",
      position = "bottom",
    },
  },
  body = "<leader>d",
  heads = {
    { "d", dap.continue },
    { "bp", dap.toggle_breakpoint },
    { "l", dap.step_into },
    { "j", dap.step_over },
    { "k", dap.step_out },
    { "h", dapui.eval },
    { "c", dap.run_to_cursor },
    {
      "bc",
      function()
        vim.ui.input({ prompt = "Condition: " }, function(condition)
          dap.set_breakpoint(condition)
        end)
      end,
    },
    {
      "?",
      function()
        vim.ui.input({ prompt = "Log: " }, function(log)
          dap.set_breakpoint(nil, nil, log)
        end)
      end,
    },
    {
      "x",
      function()
        dap.terminate()
        dapui.close {}
        dap.clear_breakpoints()
      end,
    },

    { "<Esc>", nil, { exit = true } },
  },
}

