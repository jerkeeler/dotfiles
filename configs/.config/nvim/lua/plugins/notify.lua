return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")
		notify.setup({
			stages = "fade_in_slide_out",
			timeout = 3000,
			render = "default",
			top_down = true,
		})
		vim.notify = notify
	end,
}
