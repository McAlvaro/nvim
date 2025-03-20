local utils = require("nvim-tree.utils")
local events = require("nvim-tree.events")
local lib = require("nvim-tree.lib")
local core = require("nvim-tree.core")
local notify = require("nvim-tree.notify")
local fmt = require("luasnip.extras.fmt").fmt


local find_file = require("nvim-tree.actions.finders.find-file").fn

local templates = require("mcalvaro.utils.nvim-tree.templates.java_class_templates")

local M = {}

local function get_package_name(file_path)
    local package_name = ""

    -- Encuentra el índice de 'com' en la ruta del archivo
    local com_index = vim.fn.match(file_path, 'com')

    if com_index > 0 then
        local parts = vim.fn.split(file_path:sub(com_index), "/")

        -- Elimina el último elemento (nombre del archivo)
        table.remove(parts)

        for i, part in ipairs(parts) do
            -- Convierte cada parte a notación de paquete
            part = part:gsub("-", "_"):gsub("^(%d)", "_%1"):gsub("([A-Z])", "_%1"):lower()

            -- Agrega la parte al nombre del paquete
            if i > 1 then
                package_name = package_name .. "." .. part
            else
                package_name = part
            end
        end
    end

    return package_name
end



local function create_and_notify(file, class_type)
	events._dispatch_will_create_file(file)
	local ok, fd = pcall(vim.loop.fs_open, file, "w", 420)
	if not ok then
		notify.error("Couldn't create file " .. notify.render_path(file))
		return
	end

	local class_name = vim.fn.fnamemodify(file, ":t:r")
    local package_name = get_package_name(file)

    print(package_name)

    -- local class_type = "record"

    local content = templates[class_type]

    -- Verificar si el tipo de archivo es válido
    if not content then
        notify.error("Invalid file type: " .. class_type)
        return
    end

    content = string.format(content, package_name, class_name)

    content = content:gsub("[%z\1-\31\127-\255]", "")

    -- Dividir el contenido por saltos de línea
    local lines = {}
    for line in content:gmatch("[^%^]+") do
        table.insert(lines, line)
    end

	vim.fn.writefile(lines, file)

	vim.loop.fs_close(fd)
	events._dispatch_file_created(file)
end

local function get_num_nodes(iter)
	local i = 0
	for _ in iter do
		i = i + 1
	end
	return i
end

local function get_containing_folder(node)
	if node.nodes ~= nil then
		return utils.path_add_trailing(node.absolute_path)
	end
	local node_name_size = #(node.name or "")
	return node.absolute_path:sub(0, -node_name_size - 1)
end

function M.fn(node, class_type)
	local cwd = core.get_cwd()
    print(node)
    print(class_type)
	if cwd == nil then
		return
	end

	node = node:get_parent_of_group() or node
	if not node or node.name == ".." then
		node = {
			absolute_path = cwd,
			name = "",
			nodes = core.get_explorer().nodes,
			open = true,
		}
	end

	local containing_folder = get_containing_folder(node)

	local input_opts = {
		prompt = "Create file ",
		default = containing_folder,
		completion = "file",
	}

	vim.ui.input(input_opts, function(new_file_path)
		utils.clear_prompt()
		if not new_file_path or new_file_path == containing_folder then
			return
		end

		if utils.file_exists(new_file_path) then
			notify.warn("Cannot create: file already exists")
			return
		end

		-- create a folder for each path element if the folder does not exist
		-- if the answer ends with a /, create a file for the last path element
		local is_last_path_file = not new_file_path:match(utils.path_separator .. "$")
		local path_to_create = ""
		local idx = 0

		local num_nodes = get_num_nodes(utils.path_split(utils.path_remove_trailing(new_file_path)))
		local is_error = false
		for path in utils.path_split(new_file_path) do
			idx = idx + 1
			local p = utils.path_remove_trailing(path)
			if #path_to_create == 0 and vim.fn.has("win32") == 1 then
				path_to_create = utils.path_join({ p, path_to_create })
			else
				path_to_create = utils.path_join({ path_to_create, p })
			end
			if is_last_path_file and idx == num_nodes then
				create_and_notify(path_to_create, class_type)
			elseif not utils.file_exists(path_to_create) then
				local success = vim.loop.fs_mkdir(path_to_create, 493)
				if not success then
					notify.error("Could not create folder " .. notify.render_path(path_to_create))
					is_error = true
					break
				end
				events._dispatch_folder_created(new_file_path)
			end
		end
		if not is_error then
			notify.info(notify.render_path(new_file_path) .. " was properly created")
		end

		-- synchronously refreshes as we can't wait for the watchers
		find_file(utils.path_remove_trailing(new_file_path))
	end)
end

return M
