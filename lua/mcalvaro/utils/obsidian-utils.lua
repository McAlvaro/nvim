local function find_vault_root(base_dir)
	local Path = require("obsidian.path")
	local vault_indicator_folder = ".obsidian"
	base_dir = Path.new(base_dir)
	local dirs = Path.new(base_dir):parents()
	table.insert(dirs, 1, base_dir)

	for _, dir in ipairs(dirs) do
		print(dir)
		local maybe_vault = dir / vault_indicator_folder
		print(maybe_vault)
		if maybe_vault:is_dir() then
			print(dir)
			return dir
		end
	end

	return nil
end

local function split(inputstr, sep)
	if sep == nil then
		sep = "%s" -- Usar espacio como separador predeterminado
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local function get_sub_path_after_vault(path, vault_name)
	local sep = "/" -- Separador de ruta
	local parts = split(path, sep)
	local vault_index = nil

	-- Encontrar el índice de "vault_name" en las partes
	for i, part in ipairs(parts) do
		if part == vault_name then
			vault_index = i
			break
		end
	end

	-- Si se encontró "vault_name", construir la subruta
	if vault_index then
		local sub_parts = {}
		for i = vault_index + 1, #parts do
			table.insert(sub_parts, parts[i])
		end
		return table.concat(sub_parts, sep)
	else
		return nil, "Vault name not found in the path"
	end
end

function create_note(workspace)
	local sub_path, err = get_sub_path_after_vault(workspace, "mcalvaro-vaults")

	-- Si se encuentra "mcalvaro-vaults", extraer la parte que viene después
	local workspace_path = ""
	if sub_path then
		-- Obtener la parte de la cadena después de "mcalvaro-vaults"
		workspace_path = sub_path -- +2 para saltar el '/' que sigue
	else
		print("Vault name not found in the path")
        return
	end
	vim.ui.input({ prompt = "New Note" }, function(note_name)
		vim.cmd([[startinsert]])
		if not note_name then
			return
		end

		if note_name == "" or note_name:match("^%s*$") or note_name:match('[<>:"\\|?*]') then
			vim.notify("The file name is invalid", "error", { title = "Create new note" })
			return
		end
		local command = "ObsidianNew " .. workspace_path .. "/" .. note_name

		vim.cmd("q!")
		vim.api.nvim_exec(command, false)
		vim.notify("ObsidianNew " .. workspace_path .. "/" .. note_name)
	end)
end

local function new_note_in_workspace()
	local vault_root = find_vault_root("/home/alvaro/mcalvaro-vaults") -- Directorio actual de Neovim
	if not vault_root then
		print("No se encontró el directorio del vault de Obsidian.")
		return
	end

	print("Workspaces en Obsidian:")
	file_browser({ path = tostring(vault_root) })
end

vim.api.nvim_create_user_command('ObsidianNewNoteInWorkspace', new_note_in_workspace, {})
