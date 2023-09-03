return {
	"xiyaowong/nvim-transparent",
	lazy = true,
	config = function()
		require("transparent").setup({})
	end,
    cmd = {
        "TransparentEnable",
        "TransparentDisable",
        "TransparentToggle"
    }
}
