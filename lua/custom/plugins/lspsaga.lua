return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lspsaga").setup({
      ui = {
        border = "rounded",
        devicon = true,
      },
      symbol_in_winbar = {
        enable = true,
      },
      lightbulb = {
        enable = false,
      },
    })

    -- 快捷鍵設定
    local keymap = vim.keymap.set

    -- Finder: 整合尋找定義、引用、實作
    keymap("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "Lspsaga Finder" })

    -- Code Action: 程式碼修復建議
    keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })

    -- Rename: 重新命名 (具備預覽功能)
    keymap("n", "grn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
    keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })

    -- Definition: 預覽與跳轉定義
    keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
    keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Go to Definition" })

    -- Diagnostic: 錯誤跳轉
    keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })
    keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })

    -- Hover: 顯示懸浮文檔
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Doc" })

    -- Terminal: 快速切換漂浮終端
    keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>", { desc = "Toggle Terminal" })
  end,
}
