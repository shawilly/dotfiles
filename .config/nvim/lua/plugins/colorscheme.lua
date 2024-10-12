return {
  {
    "shawilly/ponokai.nvim",
    dir = "/Users/shanewilliams/projects/ponokai.nvim/",
    dev = true,
    lazy = false,
    priority = 1000,
    config = function()
      require("ponokai-pro").setup({
        filter = "pro",
        background_clear = {
          "neo-tree",
        },
        plugins = {
          neo_tree = {},
        },
      })
    end,
  },
  -- {
  --   "shawilly/ponokai",
  --   priority = 1000,
  --   config = function()
  --     vim.g.ponokai_transparent_background = true
  --     vim.g.ponokai_enable_italic = "1"
  --     vim.g.ponokai_style = "default"
  --     vim.cmd.colorscheme("ponokai")
  --   end,
  -- },
}
