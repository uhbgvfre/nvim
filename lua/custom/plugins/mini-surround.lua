return {
  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
      mappings = {
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
      search_method = 'cover_or_next',
    },
    config = function(_, opts)
      require('mini.surround').setup(opts)

      -- Register keymaps with which-key if available
      local has_wk, wk = pcall(require, 'which-key')
      if has_wk then
        wk.add {
          { 's', group = 'Surround' },
          { 'sa', desc = 'Add surrounding' },
          { 'sd', desc = 'Delete surrounding' },
          { 'sr', desc = 'Replace surrounding' },
          { 'sf', desc = 'Find surrounding right' },
          { 'sF', desc = 'Find surrounding left' },
          { 'sh', desc = 'Highlight surrounding' },
          { 'sn', desc = 'Update search lines' },
        }
      end
    end,
  },
}
