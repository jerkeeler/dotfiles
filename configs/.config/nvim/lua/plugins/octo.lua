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
			use_local_fs = true,
		})

		-- Function to open current Octo review file in a new tab
		local function open_octo_file_in_tab()
			local reviews = require("octo.reviews")
			local review = reviews.get_current_review()

			if not review then
				vim.notify("No active Octo review", vim.log.levels.WARN)
				return
			end

			local file = review.layout:get_current_file()
			if not file then
				vim.notify("No file selected in review", vim.log.levels.WARN)
				return
			end

			-- Open the file in a new tab (relative path works from repo root)
			vim.cmd("tabedit " .. vim.fn.fnameescape(file.path))
		end

		vim.keymap.set("n", "<leader>to", open_octo_file_in_tab, {
			desc = "Open Octo review file in new tab",
		})
	end,
}
