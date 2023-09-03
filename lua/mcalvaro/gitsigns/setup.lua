require("gitsigns").setup({})

if package.loaded["gitsigns"] then
	-- Crea un autocomando para llamar a Gitsigns attach en eventos BufRead y BufNewFile
	vim.cmd([[
      augroup auto_gitsigns
      autocmd!
      autocmd BufRead,BufNewFile * silent! Gitsigns attach
      augroup END
    ]])
end
