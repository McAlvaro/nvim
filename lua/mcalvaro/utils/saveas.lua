function SaveAs()
	vim.ui.input({ prompt = "Save as: " }, function(filename)
		if not filename then
			return
		end

		if filename == "" or filename:match("^%s*$") or filename:match('[<>:"\\|?*]') then
			print("The file name is invalid")
			return
		end
		-- Verificar si se especific√≥ una ruta de directorio en el nombre de archivo
		local directory, name = filename:match("^(.*)/(.-)$")

		print("directory: " .. directory)

		-- Si no se especific√≥ una ruta de directorio, utilizar la ubicaci√≥n actual
		if not directory or directory == "" then
			directory = vim.fn.expand("%:p:h")
		end

		-- Construir la ruta completa del nuevo archivo
		local new_path = directory .. "/" .. name

		-- Verificar si el directorio existe y, de lo contrario, intentar crearlo
		if vim.fn.isdirectory(directory) == 0 then
			local success, error_msg = os.execute("mkdir -p " .. directory)
			if not success then
				print("Failed to create directory: " .. directory)
				return
			end
		end

		-- Obtener la ruta del archivo actual
		local current_path = vim.fn.expand("%:p")

		-- Construir la nueva ruta del archivo
		-- local new_path = vim.fn.expand('%:p:h') .. '/' .. filename

		-- Verificar si el archivo actual y el nuevo archivo son iguales
		if current_path == new_path then
			print("El nuevo nombre es el mismo que el archivo actual. No se realizaron cambios.")
			return
		end

		-- Copiar el contenido del archivo actual al nuevo archivo
		vim.cmd("w " .. new_path)

		-- Abrir el nuevo archivo
		vim.cmd("e " .. new_path)

		print("File saved as: " .. new_path)
	end)
end
