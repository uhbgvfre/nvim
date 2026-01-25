-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- return {}

return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup {
        variant = 'auto', -- auto, main, moon, or dawn
        dark_variant = 'main', -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        styles = {
          italic = false,
        },

        highlight_groups = {
          IblIndent = { fg = 'overlay' }, -- 使非活動縮進線隱約可見
          -- Rainbow Delimiters integration
          RainbowDelimiterRed = { fg = 'love' },
          RainbowDelimiterYellow = { fg = 'gold' },
          RainbowDelimiterBlue = { fg = 'pine' },
          RainbowDelimiterOrange = { fg = 'rose' },
          RainbowDelimiterGreen = { fg = 'foam' },
          RainbowDelimiterViolet = { fg = 'iris' },
          RainbowDelimiterCyan = { fg = 'foam' },
        },
      }
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
}
