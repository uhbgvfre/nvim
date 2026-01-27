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
      implement = {
        enable = true,
        sign = true,
        virtual_text = true,
      },
      callhierarchy = {
        enable = true,
        layout = "float",
      },
    })

    -- Keymaps
    local keymap = vim.keymap.set

    -- Finder - 尋找定義、引用和實現 (Lspsaga v3 建議使用 finder)
    keymap("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "Lspsaga Finder" })

    -- Code action - 代碼操作
    keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })

    -- Rename - 重新命名
    keymap("n", "grn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
    keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })

    -- Peek definition - 預覽定義
    keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })

    -- Go to definition - 跳轉到定義
    keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Go to Definition" })

    -- Show line diagnostics - 顯示行診斷訊息
    keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Show Line Diagnostics" })

    -- Show buffer diagnostics - 顯示整個緩衝區的診斷
    keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "Show Buffer Diagnostics" })

    -- Diagnostic jump - 跳轉到診斷位置
    keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })
    keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })

    -- Hover Doc - 顯示懸浮文件
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Doc" })

    -- Call Hierarchy - 呼叫層級 (Incoming/Outgoing calls)
    keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", { desc = "Incoming Calls" })
    keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "Outgoing Calls" })

    -- Floating terminal - 漂浮終端
    keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>", { desc = "Toggle Terminal" })
  end,
}
