return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        char = '╎', -- 居中的虛垂直線，讓非活動縮進隱約可見
      },
      scope = {
        enabled = true,
        char = '│', -- 活動 Scope 使用居中的細實垂直線
        show_start = true,
        show_end = false,
        injected_languages = true,
        priority = 1024,
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
        include = {
          node_type = {
            ["*"] = { "*" }, -- 寬鬆判定，讓大多數結構塊都能觸發 Scope
          },
        },
      },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
      local hooks = require 'ibl.hooks'
      -- 讓 Scope 線顏色與彩虹括號同步的正確 Hook 方式
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },

  {
    'hiphish/rainbow-delimiters.nvim',
    name = 'rainbow-delimiters',
    url = 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
}
