-- LEADER
vim.g.mapleader = " "

--[[ opts.lua ]]

local opt = vim.opt
local cmd = vim.api.nvim_command
local autocmd = vim.api.nvim_create_autocmd

--[[ Context ]]

--opt.colorcolumn = '80'		-- str: Mostrar columna para longitud m√°xima de l√≠nea

opt.number = true			-- bool: Mostrar n√∫meros de l√≠nea
opt.relativenumber = true		-- bool: Mostrar n√∫meros de l√≠nea relativo
opt.scrolloff = 4			-- int: N√∫mero m√≠nimo de l√≠neas de contexto top - bottom
opt.signcolumn = "yes"			-- str: Mostrar la columna de signos

--[[ Filetypes ]]
opt.encoding = 'utf8'			-- str: Codificaci√≥n de cadenas a usar
opt.fileencoding = 'utf8'		-- str: Codificaci√≥n de archivos a usar

--[[ Theme ]]
opt.syntax = "ON"			-- str: Permitir resaltado de sintaxis
opt.termguicolors = true		-- bool: Si el terminal admite el color de la interfaz de usuario, habilite

-- cmd('colorscheme github_dark')      	-- cmd: Set colors scheme
-- cmd('colorscheme onedark')      	-- cmd: Set colors scheme
-- cmd('colorscheme catppuccin-macchiato')      	-- cmd: Set colors scheme


--[[ Search ]]
opt.ignorecase = true			-- bool: Ignorar may√∫sculas y min√∫sculas en patrones de b√∫squeda
opt.smartcase = true			-- bool: Anule el caso de ignorar si la b√∫squeda contiene may√∫sculas
opt.incsearch = true			-- bool: Usar b√∫squeda incremental
opt.hlsearch = false			-- bool: Destacar coincidencias de b√∫squeda

--[[ Whitespace ]]
opt.expandtab = true			-- bool: Usa espacios en lugar de tabulaciones
opt.shiftwidth = 4			-- num: Tama√±o de una sangr√≠a
opt.softtabstop = 4			-- num: N√∫mero de espacios que cuentan las pesta√±as en el modo de inserci√≥n
opt.tabstop = 4				-- num: Cantidad de espacios que cuentan las pesta√±as

--[[ Splits ]]
opt.splitright = true			-- bool: Colocar la nueva ventana a la derecha de la actual
opt.splitbelow = true			-- bool: Colocar nueva ventana debajo de la actual

vim.loader.enable()

cmd([[autocmd VimEnter * NvimTreeClose]]) -- Close NvimTree on init Noevim

--[[ Remove Whitespace ]]
-- autocmd('BufWritePre',{
    -- pattern = '',
    -- command = ":%s/\\s\\+$//e"
-- })

