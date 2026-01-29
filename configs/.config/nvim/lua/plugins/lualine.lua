return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local noice_ok, noice = pcall(require, "noice")
    local mode_component = {
      function()
        if noice_ok then
          local mode = noice.api.status.mode.get()
          if mode then
            return mode
          end
        end
        return ""
      end,
      cond = function()
        return noice_ok and noice.api.status.mode.has()
      end,
    }
    local command_component = {
      function()
        if noice_ok then
          local cmd = noice.api.status.command.get()
          if cmd then
            return cmd
          end
        end
        return ""
      end,
      cond = function()
        return noice_ok and noice.api.status.command.has()
      end,
    }

    require("lualine").setup({
      options = {
        theme = "onedark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 }, command_component, mode_component },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
