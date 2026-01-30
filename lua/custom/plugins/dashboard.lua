return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    local header = {
      [[                                                                ]],
      [[                                                                ]],
      [[                      -#@@@@@@@@@@@@@@@%+:                      ]],
      [[                 .=@@@@@@@@@@@@@@@@@@@@@@@@%+:.                 ]],
      [[               +@%*+=--+@@@@@@@@@@@@@@@@@@@@@@*::               ]],
      [[             +=:::.........:#@@@@@@@@@@@@@@@@@@@*:.             ]],
      [[           ...................-@@@@@@@@@@@@@@@@@@@:...          ]],
      [[         .......................=@@@@@@@@@@@@@@@@@@-...         ]],
      [[        .........................:#@@@@@@@@@@@@@@@@@-...        ]],
      [[       ............................=@@@@@@@@@@@@@@@@@....       ]],
      [[      ..............................-@@@@@@@@@@@@@@@@+...:      ]],
      [[     ......:=#@@@@@@@@@@@@%*+-:......=@@@@@@@@@@@@@@@@....:     ]],
      [[     ..:*@@@@@@@@@@@@@@@@@@@@@@@@@%-..*@@@@@@@@@@@@@@@:...-     ]],
      [[    .=@@@@@@@@@@@%@%%@@%@@@%%@@@@@@@@@@@@@@@@@@@@@@@@@-...=-    ]],
      [[    +@%%%%%%%%%%@%%%%%%%%%%%%%%@%%@@@@@@%@@@@@@@@@@@@@:...=%    ]],
      [[    *%%%%%%%%@%%%%%%%%%%%%%%%%%%%%%@%@@@@%@@@@@@@@@@@@...:@%    ]],
      [[    +%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@%%@@@@@@@@@@+..:%@#    ]],
      [[    :%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@@@%%@@@@@@@@@@::+@@@:    ]],
      [[     #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@%%%%@@@@@@@@-#@@@@@     ]],
      [[     -%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@@@@@@@+     ]],
      [[      *%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@@@@@@%%%%      ]],
      [[                                                                ]],
      [[                                                                ]],
    }

    require('dashboard').setup {
      theme = 'doom',
      config = {
        header = header,
        center = {
          {
            icon = '󰈞  ',
            desc = 'Find File          ',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            icon = '󰊄  ',
            desc = 'Recent Projects    ',
            action = 'Telescope projects',
            key = 'p',
          },
          {
            icon = '󰭎  ',
            desc = 'Text Search        ',
            action = 'Telescope live_grep',
            key = 'w',
          },
          {
            icon = '  ',
            desc = 'Edit Config        ',
            action = function()
              vim.api.nvim_set_current_dir(vim.fn.stdpath 'config')
              require('telescope.builtin').find_files()
            end,
            key = 'c',
          },
          {
            icon = '󰊳  ',
            desc = 'Update Plugins     ',
            action = 'Lazy update',
            key = 'u',
          },
        },
        footer = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            '──────────────────────────────────────────────────────',
            '',
            '󰋚 NVIM v' .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch .. '  •  󰚥 ' .. stats.loaded .. '/' .. stats.count .. 'plugins  •   ' .. ms .. 'ms',
          }
        end,
      },
    }

    -- Custom coloring for the Mikasa volleyball in Rose Pine flavors
    local mikasa_ns = vim.api.nvim_create_namespace 'MikasaDashboard'
    vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter', 'VimResized' }, {
      pattern = { 'dashboard', '*' }, -- VimResized might fire when dashboard isn't the only thing, but we check inside
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo[buf].filetype ~= 'dashboard' then
          return
        end

        local function apply_rose_mikasa_colors()
          if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].filetype ~= 'dashboard' then
            return
          end

          -- Clear existing highlights
          vim.api.nvim_buf_clear_namespace(buf, mikasa_ns, 0, -1)

          -- Rose Pine Flavors:
          -- Yellow Shade 1 (Middle): Gold (#f6c177) -> @
          -- Yellow Shade 2 (Brightest): Rose (#ebbcba) -> %
          -- Yellow Shade 3 (Accent/Shadow): Iris (#c4a7e7) -> #, *
          -- Blue: Pine (#31748f) -> +, =, -, :, .
          vim.api.nvim_set_hl(0, 'MikasaGold', { fg = '#f6c177', bold = true, force = true })
          vim.api.nvim_set_hl(0, 'MikasaRose', { fg = '#ebbcba', bold = true, force = true })
          vim.api.nvim_set_hl(0, 'MikasaIris', { fg = '#c4a7e7', bold = true, force = true })
          vim.api.nvim_set_hl(0, 'MikasaPine', { fg = '#31748f', bold = true, force = true })

          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          for i, line in ipairs(lines) do
            -- Shade 1 (Gold): @
            local g1_start = 1
            while true do
              local s, e = line:find('@', g1_start)
              if not s then break end
              vim.api.nvim_buf_add_highlight(buf, mikasa_ns, 'MikasaGold', i - 1, s - 1, e)
              g1_start = e + 1
            end

            -- Shade 2 (Rose): %
            local g2_start = 1
            while true do
              local s, e = line:find('%%', g2_start)
              if not s then break end
              vim.api.nvim_buf_add_highlight(buf, mikasa_ns, 'MikasaRose', i - 1, s - 1, e)
              g2_start = e + 1
            end

            -- Shade 3 (Iris): #, *
            local gold3_chars = '[#%*]'
            local g3_start = 1
            while true do
              local s, e = line:find(gold3_chars, g3_start)
              if not s then break end
              vim.api.nvim_buf_add_highlight(buf, mikasa_ns, 'MikasaIris', i - 1, s - 1, e)
              g3_start = e + 1
            end

            -- Blue (Pine): +, =, -, :, .
            local pine_chars = '[%+=%-%:%.]'
            local p_start = 1
            while true do
              local s, e = line:find(pine_chars, p_start)
              if not s then break end
              vim.api.nvim_buf_add_highlight(buf, mikasa_ns, 'MikasaPine', i - 1, s - 1, e)
              p_start = e + 1
            end
          end
        end

        -- Execute with multiple timings
        apply_rose_mikasa_colors()
        vim.schedule(apply_rose_mikasa_colors)
        vim.defer_fn(apply_rose_mikasa_colors, 20)
        vim.defer_fn(apply_rose_mikasa_colors, 100)
        vim.defer_fn(apply_rose_mikasa_colors, 500)
      end,
    })
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
