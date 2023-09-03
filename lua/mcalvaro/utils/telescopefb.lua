SHOULD_RELOAD_TELESCOPE = true

local reloader = function()
    if SHOULD_RELOAD_TELESCOPE then
        RELOAD("plenary")
        RELOAD("telescope")
        RELOAD("mcalvaro.telescope.setup")
    end
end

local fb_actions = require("telescope").extensions.file_browser.actions
local actions = require("telescope.actions")
local action_state = require "telescope.actions.state"
local current_buf = nil
local notify = require("notify");


-- Save As Action
actions.save_as_current_bufn = function(prompt_bufnr)
  -- local symbol = action_state.get_selected_entry().value
    -- GET CURRENT DIR SELECTED
    local symbol = action_state.get_current_picker(prompt_bufnr).finder.path
    -- SaveAs( symbol )
    vim.schedule(function()
        SaveAs(symbol)
    end)
end

actions.insert_name_i = function(prompt_bufnr)
  local symbol = action_state.get_selected_entry().path
  actions.close(prompt_bufnr)
  vim.schedule(function()
    vim.cmd([[startinsert]])
    vim.api.nvim_put({ symbol }, "", true, true)
  end)
end

function SaveAs( path_selected )

    vim.ui.input({ prompt = 'Save as: ', default = path_selected .. '/'}, function(filename)
        
        if not filename then
            return
        end

        if filename == "" or filename:match("^%s*$") or filename:match('[<>:"\\|?*]') then
            print('The file name is invalid')
            notify('The file name is invalid', 'error', {title = 'Save As File'})
            return
        end
        -- Verificar si se especific‚àö‚â• una ruta de directorio en el nombre de archivo
        local directory, name = filename:match("^(.*)/(.-)$")

        print("directory: " .. directory)

        -- Si no se especific‚àö‚â• una ruta de directorio, utilizar la ubicaci‚àö‚â•n actual
        if not directory or directory == "" then
            directory = vim.fn.expand('%:p:h')
        end

       -- Construir la ruta completa del nuevo archivo
        local new_path = directory .. '/' .. name

        -- Verificar si el directorio existe y, de lo contrario, intentar crearlo
        if vim.fn.isdirectory(directory) == 0 then
            local success, error_msg = os.execute('mkdir -p ' .. directory)
            if not success then
                print('Failed to create directory: ' .. directory)
                return
            end
        end

        -- Obtener la ruta del archivo actual
        local current_path = vim.fn.expand('%:p')

        -- Verificar si el archivo actual y el nuevo archivo son iguales
        if current_path == new_path then
            print('El nuevo nombre es el mismo que el archivo actual. No se realizaron cambios.')
            return
        end

        -- Obtener el contenido de buffer actual
        local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)

        -- Copiar el contenido del archivo actual al nuevo archivo
        -- vim.cmd('w ' .. new_path)
        local file = io.open(new_path, "w")
        if not file then
            print('Failed to create file: ' .. new_path)
            return
        end

        for _, line in ipairs(lines) do
            file:write(line .. "\n")
        end

        file:close()

        -- Abrir el nuevo archivo
        vim.cmd('e! ' .. new_path)

        print('File saved as: ' .. new_path)
        notify('File saved as: ' .. new_path)
    end)
end


function file_browser_relative()
    current_buf = vim.api.nvim_get_current_buf()
    return file_browser({ path = "%:p:h" })
end

function file_browser(opts)
    opts = opts or {}

    opts = {
        path = opts.path,
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        layout_config = {
            prompt_position = "top",
        },

        attach_mappings = function(_, map)
            map("i", "<c-y>", actions.save_as_current_bufn)

            return true
        end,
    }

    return require("telescope").extensions.file_browser.file_browser(opts)
end


