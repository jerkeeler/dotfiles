-- Only load on work computer (set ENABLE_WINDSURF=1 in .zprofile)
if not vim.env.ENABLE_WINDSURF then
	return {}
end

return {
	"Exafunction/windsurf.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("codeium").setup({
			enable_cmp_source = false,
			virtual_text = {
				enabled = true,
				key_bindings = {
					accept = "<Tab>",
					accept_word = "<C-Right>",
					accept_line = "<C-Down>",
					next = "<M-]>",
					prev = "<M-[>",
					clear = "<C-]>",
				},
			},
		})
	end,
}
