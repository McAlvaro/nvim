require "config.options"

-- autocmds and keymaps can wait to load
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    require "config.vars"
    -- require "config.autocmds"
    -- require "config.usercmds"
    require "config.keys"
    require "config.diagnostic"
  end,
})

require "config.lazy"

require "mcalvaro.utils.cheatsheet"
require "mcalvaro.utils.saveas"
require "mcalvaro.utils.telescopefb"
require('telescope').load_extension "file_browser"

