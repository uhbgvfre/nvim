return {
  -- 2. 配置 snacks.nvim Dashboard
  {
    'folke/snacks.nvim',
    opts = {
      dashboard = {
        enabled = true,
        width = 46, -- 稍微調寬，確保右側有足夠空間撐開
        pane_gap = 1,
        sections = {
          -- 自定義 Header 邏輯
          function()
            local art = [[
                .-+#@@@@@@@@@%*=:.                 
            .+@@@@@@@@@@@@@@@@@@@@%-..             
          -+-::.....:*@@@@@@@@@@@@@@@+:.           
       .................#@@@@@@@@@@@@@@-...        
      ....................*@@@@@@@@@@@@@*...       
     ......................=%@@@@@@@@@@@@+...      
    ......:-+******+-:......:#@@@@@@@@@@@@....     
   ..:+@@@@@@@@@@@@@@@@@@@@*::#@@@@@@@@@@@-..:.    
   -#@@@@@@@%%@%%%%%%%@@@@@@@@@@@@@@@@@@@@-..=-    
   =%%%%%%%%%%%%%%%%%%%%%%%%@@@@@@@@@@@@@%:.:#+    
   =#%%%%%%%%%%%%%%%%%%%%%%%%@@@%@@@@@@@@*.-%@=    
   :*%%%%%%%%%%%%%%%%%%%%%%%%%@%%%@@@@@@%*@@@%:    
    =#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@@@@@@+     
     -#%%%%%#**+=-:-*%%%%%%%%%%%%%%%%%%%%%%#=      
      :++=:.......:#%%%%%%%%%%%%%%@@@@@@@@%-       
       ..:::....::#%%%%%%%%%%%%%@@@@@@@@@=.        
          .:....:*%%%%%%%%%%@@@**#%@%#+.           
             ...:#%%%%%%%%%%@@@#-:::.              
                ..-=++********+-..                 
]]
            local lines = vim.split(art, '\n')
            local rows = {}
            for _, line in ipairs(lines) do
              if line:gsub('%s+', '') ~= '' then
                local text_parts = {}
                local current_chunk = ''
                local last_hl = nil

                for i = 1, #line do
                  local char = line:sub(i, i)
                  local hl = 'SnacksDashboardHeader'

                  if char == '@' then hl = 'MikasaGold'
                  elseif char == '%' then hl = 'MikasaRose'
                  elseif char:find '[#%*]' then hl = 'MikasaIris'
                  elseif char:find '[%+=%-%:%.]' then hl = 'MikasaPine'
                  end

                  if hl == last_hl then
                    current_chunk = current_chunk .. char
                  else
                    if current_chunk ~= '' then
                      table.insert(text_parts, { current_chunk, hl = last_hl })
                    end
                    current_chunk = char
                    last_hl = hl
                  end
                end
                if current_chunk ~= '' then
                  table.insert(text_parts, { current_chunk, hl = last_hl })
                end
                -- 將 align 改為 left 並維持適度縮進，可以減少左側空白
                table.insert(rows, { text = text_parts, align = 'left', indent = 2 })
              end
            end
            table.insert(rows, { text = '', padding = 1 })
            return rows
          end,
          -- 右側 Widget
          {
            pane = 2,
            gap = 1,
            { section = 'keys', gap = 1, padding = 1, width = 30 }, -- 固定寬度 30
            { text = '', padding = 1 }, -- 在 divider 上方加空行
            { text = '──────────────────────────────', hl = 'MikasaIris', width = 30, align = 'center' }, -- 撐滿 30 寬並置中
            { text = '', padding = 1 }, -- 在 divider 下方加空行
            function()
              local stats = require('lazy').stats()
              local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
              local version = 'v' .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch
              return {
                align = 'center', -- 文字置中
                width = 30,
                text = {
                  { 'NVIM ', hl = 'MikasaGold' },
                  { version, hl = 'MikasaGold' },
                  { ' • ', hl = 'MikasaPine' },
                  { '󰚥 ', hl = 'MikasaIris' },
                  { stats.loaded .. '/' .. stats.count .. ' plugins in ', hl = 'MikasaRose' },
                  { ms .. 'ms', hl = 'MikasaIris' },
                },
              }
            end,
          },
        },
        preset = {
          keys = {
            { icon = '󰈞 ', icon_hl = 'MikasaGold', key = 'f', key_hl = 'MikasaIris', desc = 'Find File', desc_hl = 'MikasaRose', action = ':Telescope find_files' },
            { icon = '󰊄 ', icon_hl = 'MikasaGold', key = 'p', key_hl = 'MikasaIris', desc = 'Recent Projects', desc_hl = 'MikasaRose', action = ':Telescope projects' },
            { icon = '󰭎 ', icon_hl = 'MikasaGold', key = 'w', key_hl = 'MikasaIris', desc = 'Text Search', desc_hl = 'MikasaRose', action = ':Telescope live_grep' },
            {
              icon = ' ',
              icon_hl = 'MikasaGold',
              key = 'c',
              key_hl = 'MikasaIris',
              desc = 'Edit Config',
              desc_hl = 'MikasaRose',
              action = function()
                vim.api.nvim_set_current_dir(vim.fn.stdpath 'config')
                require('telescope.builtin').find_files()
              end,
            },
            { icon = '󰊳 ', icon_hl = 'MikasaGold', key = 'u', key_hl = 'MikasaIris', desc = 'Update Plugins', desc_hl = 'MikasaRose', action = ':Lazy update' },
            { icon = ' ', icon_hl = 'MikasaGold', key = 'q', key_hl = 'MikasaIris', desc = 'Quit', desc_hl = 'MikasaRose', action = ':qa' },
          },
        },
      },
    },

    config = function(_, opts)
      require('snacks').setup(opts)
      local colors = {
        MikasaGold = { fg = '#f6c177', bold = true },
        MikasaRose = { fg = '#ebbcba', bold = true },
        MikasaIris = { fg = '#c4a7e7', bold = true },
        MikasaPine = { fg = '#31748f', bold = true },
      }
      for group, color in pairs(colors) do
        vim.api.nvim_set_hl(0, group, color)
      end
    end,
  },
}



