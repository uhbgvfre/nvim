return {
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    lazy = false,
    opts = {
        max_count = 10,
        disabled_keys = {
            ["<Up>"] = false,
            ["<Down>"] = false,
            ["<Left>"] = false,
            ["<Right>"] = false,
        },
    },
  },
}
