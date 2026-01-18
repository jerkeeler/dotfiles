return {
	"crispgm/cmp-beancount",
	ft = "beancount",
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local cmp = require("cmp")

		-- Set up beancount-specific completion sources
		-- The 'account' option should point to your main beancount file
		-- that contains all account definitions (or includes them)
		cmp.setup.filetype("beancount", {
			sources = cmp.config.sources({
				{
					name = "beancount",
					option = {
						-- Update this path to your main beancount file
						account = "~/Documents/personal_important/personal_ledger_redux/ledger.beancount",
					},
				},
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
	end,
}
