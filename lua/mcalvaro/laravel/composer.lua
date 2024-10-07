local M = {
	job = nil,
}

local notify_spinner = require("mcalvaro.notify.loading-notify")

function M.dumpautoload()
	if M.job ~= nil then
		vim.notify("Composer dump-autoload is already running", vim.log.levels.WARN, { timeout = 2000 })
		return
	end

	local client_id = "composer_dump" -- Identificador único para la notificación
	local token = "loading" -- Token para la notificación

    notify_spinner.start_loading(client_id, token, "Running Composer dump-autoload...")

	M.job = vim.system(
		{ "composer", "dump-autoload" },
		{ text = true },
		vim.schedule_wrap(function(result)
			M.job = nil

			if result.code == 0 then
                notify_spinner.stop_loading(client_id, token, "Composer dump-autoload completed successfully", vim.log.levels.INFO)
			else
                notify_spinner.stop_loading(client_id, token, "Composer dump-autoload failed", vim.log.levels.ERROR)
			end
		end)
	)
end

vim.api.nvim_create_user_command("ComposerDumpAutoload", function()
	M.dumpautoload()
end, {})

return M
