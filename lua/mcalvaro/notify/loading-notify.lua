local M = {}

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

function M.start_loading(client_id, token, message)
    local notif_data = get_notif_data(client_id, token)
    notif_data.spinner = 0

    notif_data.notification = vim.notify(message, nil, {
        hide_from_history = true,
        icon = spinner_frames[1],
    })

    -- Start the spinner
    update_spinner(client_id, token)
end

function M.stop_loading(client_id, token, message, level)
    local notif_data = get_notif_data(client_id, token)
    notif_data.spinner = nil

    -- Replace the notification with the final message
    vim.notify(message, level, { replace = notif_data.notification, timeout = 950 })
end

return M
