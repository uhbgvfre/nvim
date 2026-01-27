return {
  'Wansmer/symbol-usage.nvim',
  event = 'LspAttach', -- 靈魂：當 LSP 啟動時才加載
  config = function()
    local SymbolUsage = require('symbol-usage')

    -- 自定義顯示格式：例如 "3 references | 1 implementation"
    local function text_format(symbol)
      local fragments = {}

      -- 引用次數
      if symbol.references then
        local usage = symbol.references <= 1 and 'reference' or 'references'
        table.insert(fragments, ('%d %s'):format(symbol.references, usage))
      end

      -- 實作次數
      if symbol.implementation then
        local usage = symbol.implementation <= 1 and 'implementation' or 'implementations'
        table.insert(fragments, ('%d %s'):format(symbol.implementation, usage))
      end

      return table.concat(fragments, ' | ')
    end

    SymbolUsage.setup({
      text_format = text_format,
      -- 只在較大的符號（類別、方法）顯示，避免每一行都是文字
      kinds = {
        vim.lsp.protocol.SymbolKind.Class,
        vim.lsp.protocol.SymbolKind.Method,
        vim.lsp.protocol.SymbolKind.Interface,
        vim.lsp.protocol.SymbolKind.Function,
      },
      vt_position = 'above', -- 顯示在定義的上方一行 (VS Code 風格)
    })
  end,
}
