function filter_lsp_client(client)
	local filetype = vim.bo.filetype
	if client.name == "tsserver" and filetype == "vue" then
		return false
	end
	return true
end
