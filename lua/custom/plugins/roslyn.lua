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
      choose_target = function(targets)
        for _, target in ipairs(targets) do
          if target:find 'Assembly%-CSharp%.sln' then
            return target
          end
        end
        return targets[1]
      end,
    },
  },
}
