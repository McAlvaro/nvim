return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function ()
        require('mcalvaro.bufferline.setup')
    end,
}
