return {
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = function()
      local ai = require 'mini.ai'
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
          d = { '%f[%d]%d+' }, -- digits
          e = { -- Word with case
            { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
            '^().*()$',
          },
        },
      }
    end,
    config = function(_, opts)
      require('mini.ai').setup(opts)

      -- Register via which-key if available
      local has_wk, wk = pcall(require, 'which-key')
      if has_wk then
        local objects = {
          { ' ', desc = 'whitespace' },
          { '"', desc = '" string' },
          { "'", desc = "' string" },
          { '(', desc = '() block' },
          { ')', desc = '() block with ws' },
          { '<', desc = '<> block' },
          { '>', desc = '<> block with ws' },
          { '?', desc = 'user prompt' },
          { 'U', desc = 'use/call without dot' },
          { '[', desc = '[] block' },
          { ']', desc = '[] block with ws' },
          { '_', desc = 'underscore' },
          { '`', desc = '` string' },
          { 'a', desc = 'argument' },
          { 'b', desc = ')]} block' },
          { 'c', desc = 'class' },
          { 'd', desc = 'digit(s)' },
          { 'e', desc = 'CamelCase / snake_case' },
          { 'f', desc = 'function' },
          { 'g', desc = 'entire file' },
          { 'i', desc = 'indent' },
          { 'o', desc = 'block, conditional, loop' },
          { 'q', desc = 'quote `"\'' },
          { 't', desc = 'tag' },
          { 'u', desc = 'use/call' },
          { '{', desc = '{} block' },
          { '}', desc = '{} with ws' },
        }

        local ret = { mode = { 'o', 'x' } }
        for prefix, name in pairs {
          i = 'inside',
          a = 'around',
          il = 'last',
          ['in'] = 'next',
          al = 'last',
          an = 'next',
        } do
          table.insert(ret, { prefix, group = name })
          for _, obj in ipairs(objects) do
            table.insert(ret, { prefix .. obj[1], desc = obj.desc })
          end
        end
        wk.add(ret)
      end
    end,
  },
}
