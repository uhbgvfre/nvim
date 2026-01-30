return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {
      -- 偵測根目錄的方式，包括常用的 C# 專案檔
      detection_methods = { 'lsp', 'pattern' },
      patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '.sln', '.csproj' },
      -- 不要自動切換目錄，以免在切換 buffer 時產生意料之外的跳轉
      -- 我們會透過 Telescope 手動或在特定的情況下執行為主
      manual_mode = false,
    }
    -- 整合進 Telescope
    require('telescope').load_extension 'projects'
  end,
}
