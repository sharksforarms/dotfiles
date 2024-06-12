return {
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        -- overwrite default configuration
        -- here, e.g. to enable default bindings
        copy_sync = {
          -- TODO: Couldn't get this to work properly, not sure if I really want this anyway
          enable = false,
          sync_clipboard = false,
          sync_deletes = false,
          sync_unnamed = false,
        },
        navigation = {
          -- enables default keybindings (C-hjkl) for normal mode
          enable_default_keybindings = true,
        },
        resize = {
          -- enables default keybindings (A-hjkl) for normal mode
          enable_default_keybindings = true,
          -- sets resize steps for x axis
          resize_step_x = 10,
          -- sets resize steps for y axis
          resize_step_y = 10,
        },
      })
    end,
  },
}
