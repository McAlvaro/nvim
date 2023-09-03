return {
	"iamcco/markdown-preview.nvim",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
    dependencies = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
    lazy = true,
	ft = "markdown",
	cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
}
