return {
    "r-yoshida1992/nightly.nvim",
    event = {"VimEnter"},
    config = function()
      require("nightly").setup({
        transparent = false,
        styles = {
          comments = { italic = false, fg = "#888888" },
          functions = { italic = false },
          variables = { italic = false },
          keywords = { italic = false },
        },
        highlights = {},
      })
      vim.cmd("colorscheme nightly")
    end,
}
