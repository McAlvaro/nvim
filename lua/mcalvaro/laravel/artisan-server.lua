local M = {
    job = nil,
}

function M.start()
    M.job = vim.system(
        { "php", "artisan", "serve" },
        {},
        vim.schedule_wrap(function(out)
            M.job = nil
            vim.notify("Laravel Server Stopped", vim.log.levels.INFO, { timeout = 2000 })
        end)
    )
    vim.notify("Laravel Server Started on http://localhost:8000", vim.log.levels.INFO, { timeout = 2000 })
end

function M.stop()
    if M.job then
        -- M.job:kill(15)
        if M.running() then
            vim.system(
                { "pkill", "-P", tostring(M.job.pid) },
                {},
                vim.schedule_wrap(function()
                    vim.notify("Laravel Server Stopped", vim.log.levels.INFO, { timeout = 2000 })
                    M.job = nil
                end)
            )
        end
    end
end

function M.running()
    return M.job ~= nil
end

function M.text()
    return "󰫐 "
end

vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    callback = function()
        M.stop()
    end,
})

vim.api.nvim_create_user_command("ArtisanServeStart", function ()
    M.start()
end, {})

vim.api.nvim_create_user_command("ArtisanServeStop", function ()
    M.stop()
end, {})

return M
