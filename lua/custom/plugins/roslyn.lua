return {
  {
    'seblj/roslyn.nvim',
    ft = 'cs',
    opts = {
      config = {
        settings = {
          csharp = {
            completion = {
              showCompletionItemsFromUnimportedNamespaces = true,
              enableImportCompletion = true,
            },
            backgroundAnalysis = {
              analyzerDiagnosticsScope = 'fullSolution',
            },
          },
        },
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      },
      exe = 'roslyn.cmd',
    },
  },
}
