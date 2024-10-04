local M = {
	job = nil,
}

-- Función para limpiar las secuencias de escape ANSI
local function remove_ansi_escape_sequences(text)
	return text:gsub("\27%[%d+;%d+;%d+m", ""):gsub("\27%[%d+m", ""):gsub("\x1b%[%d+;%d+m", "")
end

-- Utilidad para manejar notificaciones con spinner
local client_notifs = {}
local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function get_notif_data(client_id, token)
	if not client_notifs[client_id] then
		client_notifs[client_id] = {}
	end

	if not client_notifs[client_id][token] then
		client_notifs[client_id][token] = {}
	end

	return client_notifs[client_id][token]
end

local function update_spinner(client_id, token)
	local notif_data = get_notif_data(client_id, token)

	if notif_data.spinner then
		local new_spinner = (notif_data.spinner + 1) % #spinner_frames
		notif_data.spinner = new_spinner

		notif_data.notification = vim.notify(nil, nil, {
			hide_from_history = true,
			icon = spinner_frames[new_spinner],
			replace = notif_data.notification,
		})

		vim.defer_fn(function()
			update_spinner(client_id, token)
		end, 100)
	end
end

function M.dumpautoload()
	if M.job ~= nil then
		vim.notify("Composer dump-autoload is already running", vim.log.levels.WARN, { timeout = 2000 })
		return
	end

	local client_id = "composer_dump" -- Identificador único para la notificación
	local token = "loading" -- Token para la notificación
	local notif_data = get_notif_data(client_id, token)
	notif_data.spinner = 0

	notif_data.notification = vim.notify("Running Composer dump-autoload...", nil, {
		hide_from_history = true,
		icon = spinner_frames[1],
	})

	update_spinner(client_id, token)

	M.job = vim.system(
		{ "composer", "dump-autoload" },
		{ text = true },
		vim.schedule_wrap(function(result)
			M.job = nil
			notif_data.spinner = nil 

			if result.code == 0 then
				vim.notify(
					"Composer dump-autoload completed successfully",
					nil,
					{ replace = notif_data.notification, timeout = 950 }
				)
			else
				vim.notify(
					"Composer dump-autoload failed",
					vim.log.levels.ERROR,
					{ timeout = 1000, replace = notif_data.notification }
				)
			end
		end)
	)
end

vim.api.nvim_create_user_command("ComposerDumpAutoload", function()
	M.dumpautoload()
end, {})

return M
