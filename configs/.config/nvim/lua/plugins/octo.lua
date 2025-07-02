return {
	"pwntester/octo.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
		"ibhagwan/fzf-lua",
		-- OR 'nvim-telescope/telescope.nvim',
		-- OR 'folke/snacks.nvim',
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("octo").setup({
			picker = "fzf-lua",
			r,
		})
	end,
}
