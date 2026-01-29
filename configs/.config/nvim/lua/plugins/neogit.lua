return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ibhagwan/fzf-lua",
		"sindrets/diffview.nvim",
	},
	config = function()
		local neogit = require("neogit")
		neogit.setup({
			integrations = {
				fzf_lua = true,
				diffview = true,
			},
		})

		vim.keymap.set("n", "<leader>gg", function()
			neogit.open()
		end, { desc = "Open Neogit" })
	end,
}
