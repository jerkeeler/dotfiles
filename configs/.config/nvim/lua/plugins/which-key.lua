return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      delay = 300,
      icons = {
        mappings = false,
      },
    })
    wk.add({
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>n", group = "notifications" },
      { "<leader>s", group = "split" },
      { "<leader>d", group = "diagnostics" },
      { "<leader>t", group = "tab" },
      { "<leader>y", group = "yazi" },
    })
  end,
}
