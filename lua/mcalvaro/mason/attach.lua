
local filetype_attach = setmetatable({}, {
	__index = function()
		return function() end
	end,
})
return function (client, bufnr)
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    -- vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Attach any filetype specific options to the client
	filetype_attach[filetype](client, bufnr)
end


