return {
	"rcarriga/nvim-notify",
	lazy = false,
	config = function()
		local notify = require("notify")
		-- this overwrites the vim notify function
		vim.notify = notify.notify
	end,
}
