return {
  {
    'apyra/nvim-unity-sync',
    lazy = false,
    config = function()
      -- 如果沒有安裝 nvim-tree，就偽裝一個假的 api 模組來騙過插件，防止它噴錯
      if not pcall(require, 'nvim-tree.api') then
        package.preload['nvim-tree.api'] = function()
          return {
            events = {
              subscribe = function() end,
              Event = setmetatable({}, {
                __index = function()
                  return 0
                end,
              }),
            },
          }
        end
      end

      require('unity.plugin').setup()
    end,
  },
}
