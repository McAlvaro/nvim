--[[ vars.lua ]]
--

local g = vim.g

-- Permite la compatibilidad con 256 colores.
g.t_co = 256

-- Establece la variable global del fondo
g.background = "dark"


g.python3_host_prog = vim.fn.getcwd() .. '/.venv/bin/python3'

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Theme Custom Colors
-- g.dracula_colors = {
--    bg = "#2b2b2b",
--    menu = "#3f3f3f"
-- }
-- vim.g.github_transparent = true

