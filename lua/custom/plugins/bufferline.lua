return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    keys = {
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<leader>bp', '<cmd>BufferLinePick<cr>', desc = 'Buffer Pick' },
      { '<leader>bc', '<cmd>BufferLinePickClose<cr>', desc = 'Buffer Pick Close' },
      { '<leader>bd', '<cmd>bdelete<cr>', desc = 'Delete Buffer' },
      { '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', desc = 'Close Left' },
      { '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = 'Close Right' },
      { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close Others' },
    },
    opts = function()
      return {
        options = {
          mode = 'buffers',
          style_preset = require('bufferline').style_preset.default,
          themable = true,
          numbers = 'none',
          close_command = 'bdelete! %d',
          right_mouse_command = 'bdelete! %d',
          left_mouse_command = 'buffer %d',
          middle_mouse_command = nil,
          indicator = {
            icon = '▎',
            style = 'icon',
          },
          buffer_close_icon = '󰅖',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 18,
          max_prefix_length = 15,
          tab_size = 18,
          diagnostics = 'nvim_lsp',
          diagnostics_update_in_insert = false,
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'File Explorer',
              text_align = 'left',
              separator = true,
            },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          separator_style = 'thin',
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' },
          },
          sort_by = 'insert_after_current',
        },
      }
    end,
    config = function(_, opts)
      require('bufferline').setup(opts)
    end,
  },
}
