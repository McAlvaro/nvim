-- Función para ejecutar el proyecto Spring
local function excute_spring_server(profile)
	local file_path = get_main_file_app()

    if not file_path then
        vim.notify("Main no encontrado", "error")
        return
    end

	local class_name = nil
	local project_name = nil

	-- Verifica si el archivo existe y extrae el nombre de la clase principal
	local file = io.open(file_path, "r")
	if file then
		local content = file:read("*all")
		-- class_name = content:match("public%s+class%s+(%w+)Application%s*{")
        class_name = content:match("public%s+class%s+(%w+)%s*{")

        project_name = content:match("package%s+([%w%.]+);")
        vim.notify("Spring Project: ".. project_name)
		file:close()
	else
		vim.notify("No se pudo abrir el archivo:" .. file_path, "error")
		return
	end

	if not class_name then
		vim.notify("No se encontró la clase principal en el archivo.", "error")
		return
	end

	if not project_name then
		vim.notify("No se encontró el package.", "error")
		return
	end

    local is_quiet = string.find(profile, "quiet")

    if is_quiet then
        profile = string.gsub(profile, "[(]quiet[)]", "")
    end

    vim.notify("Profile: " ..  profile)

	local run_command = string.format(
		"mvn%s clean compile && mvn exec:java -Dexec.mainClass=%s.%s " .. (profile ~= "default" and "-Dspring.profiles.active=" .. profile or "" ) .. "%s",
        (is_quiet ~= nil and " -q" or ""),
		project_name,
		class_name,
        (is_quiet ~= nil and " |grep -v INFO" or "")
	)

	-- Ejecuta el comando para iniciar el servidor y muestra los logs en una nueva terminal
	local term_command = string.format('TermExec cmd="%s" name="springproject-%s"', run_command, class_name)
	vim.api.nvim_command(term_command)

end

function get_main_file_app()
	-- Obtiene el directorio actual de Neovim
	local current_directory = vim.fn.getcwd()

	-- Busca archivos Java en el directorio actual
	-- local java_main_files = vim.fn.systemlist("find " .. current_directory .. ' -name "*Application.java"') or vim.fn.systemlist("find " .. current_directory .. ' -name "*Main.java"')
    local java_main_files = vim.fn.systemlist(string.format("find %s -name '*Application.java' -o -name '*Main.java'", current_directory))

    if not java_main_files then
        return nil
    end

    return java_main_files[1]

end


function start_spring_server()
    local profiles = {"default", "dev", "local", "default(quiet)"}

    vim.ui.select(profiles, {
        prompt = "Select Profile",
        telescope = require("telescope.themes").get_dropdown()
    }, function (selected)

        if not selected then
            return nil
        end

        excute_spring_server(selected)
    end)
end

function get_first_terminal()
    local terminal_chans = {}
		for _, chan in pairs(vim.api.nvim_list_chans()) do
			if chan["mode"] == "terminal" and chan["pty"] ~= "" then
				table.insert(terminal_chans, chan)
			end
		end
		table.sort(terminal_chans, function(left, right)
			return left["buffer"] < right["buffer"]
		end)
		if #terminal_chans == 0 then
            vim.notify("No hay terminal")
			return nil
		end
        print(terminal_chans[1]["id"])
		return terminal_chans[1]["id"]
end

local send_to_terminal = function(terminal_chan, term_cmd_text)
        local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
    vim.api.nvim_chan_send(terminal_chan, term_cmd_text )
end

function stop_spring_server()
    local terminal = get_first_terminal()
	if not terminal then
		return nil
	end

    local exit = vim.api.nvim_replace_termcodes("<C-c>", true, true, true)
    local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
    send_to_terminal(terminal, exit)
    send_to_terminal(terminal, "clear" .. enter)

end

function send_command()
    local send_to_terminal = function(terminal_chan, term_cmd_text)
            local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
		vim.api.nvim_chan_send(terminal_chan, term_cmd_text )
	end

    local cmd_text = nil

    local terminal = get_first_terminal()
	if not terminal then
		return nil
	end

	if not cmd_text then
		vim.ui.input({ prompt = "Send to terminal: " }, function(input_cmd_text)
			if not input_cmd_text then
				return nil
			end
            local exit = vim.api.nvim_replace_termcodes("<C-c>", true, true, true)
			send_to_terminal(terminal, exit)
		end)
	else
		send_to_terminal(terminal, cmd_text)
	end
	return true

end

function restart_spring_server()
    stop_spring_server()
    start_spring_server()
end

function MavenStop()
    -- Lógica para detener el servidor Maven
end

function MavenStart()
    -- Lógica para detener el servidor Maven
end

function MavenRestart()
    -- Lógica para detener el servidor Maven
end

function maven_enable_controls(is_active)
    local icons = {
      start = "",
      restart = "",
      stop = "",

    }

      vim.cmd([[
  hi default MavenStart guifg=#00f1f5
  hi default MavenStop guifg=#F70067
  hi default MavenRestart guifg=#A9FF68
    ]])

    local bar = ""
    local commands = {
        { cmd = "MavenStart", icon = icons.start},
        { cmd = "MavenRestart", icon = icons.restart},
        { cmd = "MavenStop", icon = icons.stop },
    }

    for _, elem in ipairs(commands) do
        bar = bar .. ("  %%#%s#%%0@%s%%#0#"):format(
            elem.cmd,
            elem.icon
        )
    end

    return bar
end


function CheckWebServerStatus()
    local dapui_float = require('dapui.windows.float')
    local controls = require("mcalvaro.utils.controles")

    -- Abre una ventana flotante con un tamaño específico y muestra un mensaje
    local float_win = dapui_float.open_float({
        height = 1,
        width = 200,
        position = { line = 63, col = 207 },
    })

    -- Escucha el evento de cerrar la ventana flotante
    float_win:listen('close', function()
        print('La ventana flotante se cerró')
    end)

    -- controls.enable_controls(float_win)
    --
    vim.api.nvim_buf_set_lines(float_win:get_buf(), 0, -1, false, {
        maven_enable_controls(true),
    })


    -- Actualiza el contenido de la ventana flotante
    -- vim.api.nvim_buf_set_lines(float_win:get_buf(), 0, -1, false, {
    --     'El servidor web está levantado.',
    -- })
end
