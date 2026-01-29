return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  keys = {
    { '<leader>db', '<cmd>Dashboard<cr>', desc = 'Dashboard' },
  },
  config = function()
    local header = {
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
    }

    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = header,
        week_header = {
          enable = false,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Apps',
            group = 'Label',
            action = 'Telescope commands',
            key = 'a',
          },
          {
            icon = '󰭎 ',
            icon_hl = '@variable',
            desc = 'Word',
            group = 'Label',
            action = 'Telescope live_grep',
            key = 'w',
          },
          {
            icon = '󰊢 ',
            icon_hl = '@variable',
            desc = 'LazyGit',
            group = 'Label',
            action = 'LazyGit',
            key = 'g',
          },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Config',
            group = 'Label',
            action = 'edit ' .. vim.fn.stdpath 'config' .. '/init.lua',
            key = 'c',
          },
        },
      },
    }

    -- Custom coloring for the Mikasa volleyball in Rose Pine flavors
    local mikasa_ns = vim.api.nvim_create_namespace 'MikasaDashboard'
    vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter' }, {
      pattern = 'dashboard',
      callback = function()
        local buf = vim.api.nvim_get_current_buf()

        local function apply_rose_mikasa_colors()
          if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].filetype ~= 'dashboard' then
            return
          end

          -- Clear existing highlights to prevent overlap/stacking
          vim.api.nvim_buf_clear_namespace(buf, mikasa_ns, 0, -1)

          -- Rose Pine Flavors:
          -- Yellow Shade 1: Gold (#f6c177) - Middle
          -- Yellow Shade 2: Rose (#ebbcba) - Brightest
          -- Yellow Shade 3: Muted Gold (#908caa) - Darker/Subtle (using 'subtle' or a mix)
          vim.api.nvim_set_hl(0, 'MikasaGold', { fg = '#f6c177', bold = true, force = true })
          vim.api.nvim_set_hl(0, 'MikasaRose', { fg = '#ebbcba', bold = true, force = true })
          vim.api.nvim_set_hl(0, 'MikasaMutedGold', { fg = '#c4a7e7', bold = true, force = true }) -- Iris for a different warm shade
          vim.api.nvim_set_hl(0, 'MikasaPine', { fg = '#31748f', bold = true, force = true })

          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          for i, line in ipairs(lines) do
            -- [Disjoint Sets - 3 Shades of Yellow]
            
            -- Set 1 (Gold - Middle): @
            local gold1_chars = '@'
            local g1_start = 1
            while true do
              local s, e = line:find(gold1_chars, g1_start)
              if not s then break end
              vim.api.nvim_buf_add_highlight(buf, mikasa_ns, 'MikasaGold', i - 1, s - 1, e)
              g1_start = e + 1
            end

            -- Set 2 (Rose - Brightest): %
            local gold2_chars = '%%'
            local g2_start = 1
            while true do
              local s, e = line:find(gold2_chars, g2_start)
              if not s then break end
              vim.api.nvim_buf_add_highlight(buf, mikasa_ns, 'MikasaRose', i - 1, s - 1, e)
              g2_start = e + 1
            end

            -- Set 3 (Muted/Iris - Accent/Shadow): #, *
            local gold3_chars = '[#%*]'
            local g3_start = 1
            while true do
              local s, e = line:find(gold3_chars, g3_start)
              if not s then break end
              vim.api.nvim_buf_add_highlight(buf, mikasa_ns, 'MikasaMutedGold', i - 1, s - 1, e)
              g3_start = e + 1
            end

            -- Set 4 (Pine Blue): +, =, -, :, .
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

        -- Execute immediately and with delays to ensure capture after dashboard/theme setup
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
