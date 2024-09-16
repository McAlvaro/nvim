function filter_lsp_client(client)
	local filetype = vim.bo.filetype
	if client.name == "ts_ls" and filetype == "vue" then
		return false
	end
	return true
end
