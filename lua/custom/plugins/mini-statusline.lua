return {
  {
    'echasnovski/mini.statusline',
    version = '*',
    event = 'VeryLazy',
    config = function()
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup {
        use_icons = vim.g.have_nerd_font,
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
            local git = statusline.section_git { trunc_width = 40 }
            local diff = statusline.section_diff { trunc_width = 75 }
            local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
            local lsp = statusline.section_lsp { trunc_width = 75 }
            local filename = statusline.section_filename { trunc_width = 140 }
            local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
            local location = statusline.section_location { trunc_width = 75 }
            local search = statusline.section_searchcount { trunc_width = 75 }

            return statusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl, strings = { search, location } },
            }
          end,
        },
        set_vim_settings = false, -- We handle this elsewhere or let defaults apply
      }

      -- Custom colors for the statusline to match the theme or preference
      -- You can adjust these highlight groups to your liking
      -- vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { fg = '#ff9e64', bg = '#24283b' })
      -- vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { fg = '#c0caf5', bg = '#24283b' })
      -- vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { fg = '#7aa2f7', bg = '#24283b' })
    end,
  },
}
