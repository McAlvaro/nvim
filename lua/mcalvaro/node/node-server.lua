local M = {
    job = nil,
    port = 5173,
}

function M.start()
    M.job = vim.system(
        { "npm", "run", "dev" },
        {},
        vim.schedule_wrap(function(out)
            M.job = nil
        end)
    )
end

function M.stop()
    if M.running() then
        -- Buscamos el proceso en el puerto 5173 y lo matamos
        vim.system(
            { "lsof", "-t", "-i", ":" .. tostring(M.port) },
            {},
            vim.schedule_wrap(function(result)
                for pid in result.stdout:gmatch("%d+") do
                    if pid then
                        vim.system({ "kill", "-9", tostring(pid) }, {}, vim.schedule_wrap(function(out) end))
                    else
                        vim.notify(
                            "No server found on port " .. tostring(M.port),
                            vim.log.levels.WARN,
                            { timeout = 2000 }
                        )
                    end
                end

                vim.notify("Node server stopped", vim.log.levels.INFO, { timeout = 2000 })
                M.job = nil
            end)
        )
    end
end

function M.running()
    return M.job ~= nil
end

function M.text()
    return "󰎙 "
end

vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    callback = function()
        M.stop()
    end,
})

vim.api.nvim_create_user_command("NodeServerStart", function()
    M.start()
end, {})

vim.api.nvim_create_user_command("NodeServerStop", function()
    M.stop()
end, {})

return M
