return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	ft = "markdown",
	config = function()
		require("render-markdown").setup({
			-- Configuration here, or leave empty to use defaults
		})
	end,
}
