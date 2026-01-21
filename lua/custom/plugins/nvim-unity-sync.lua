return {
  {
    'apyra/nvim-unity-sync',
    lazy = false,
    config = function()
      require('unity.plugin').setup()

      -- Global autocommands for general file monitoring
      local group = vim.api.nvim_create_augroup('UnitySyncGroup', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufNewFile', 'BufDelete' }, {
        group = group,
        pattern = '*.cs',
        callback = function()
          vim.cmd 'Usync'
        end,
      })
    end,
  },
}
