return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		vim.keymap.set("n", "<leader>fn", "<cmd>Noice pick<cr>", { desc = "Find notifications" })
		vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<cr>", { desc = "Dismiss notifications" })

		require("noice").setup({
			cmdline = {
				enabled = true,
				view = "cmdline",
			},
			messages = {
				enabled = true,
			},
			popupmenu = {
				enabled = true,
			},
			notify = {
				enabled = true,
			},
			lsp = {
				progress = {
					enabled = true,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
			},
		})
	end,
}
