local M = {
    job = nil,
}

local notify_spinner = require("mcalvaro.notify.loading-notify")

function M.optimize()
    if M.job ~= nil then
        vim.notify("Artisan optimize is already running", vim.log.levels.WARN, { timeout = 2000 })
    end

    local client_id = "artisan_optimize"
    local token = "loading"

    notify_spinner.start_loading(client_id, token, "Running Artisan optimize...")

    M.job = vim.system(
        { "php", "artisan", "optimize" },
        { text = true },
        vim.schedule_wrap(function(result)

            M.job = nil

            if result.code == 0 then
                notify_spinner.stop_loading(client_id, token, "Artisan optimize completed successfully", vim.log.levels.INFO)
            else
                notify_spinner.stop_loading(client_id, token, "Artisan optimize failed", vim.log.levels.ERROR)
            end
        end)
    )
end

vim.api.nvim_create_user_command("ArtisanOptimize", function()
    M.optimize()
end, {})

return M
