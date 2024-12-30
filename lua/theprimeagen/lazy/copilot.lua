return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter", -- Load Copilot when entering Insert mode
  config = function()
    -- Copilot setup
    require("copilot").setup({
      suggestion = {
        auto_trigger = true, -- Automatically trigger suggestions
      },
    })

    -- Keymap setup for Copilot
    local copilot = require("copilot.suggestion")

    vim.keymap.set("i", "<Tab>", function()
      if copilot.is_visible() then
        copilot.accept() -- Accept the suggestion
      else
        -- Fallback to default <Tab> behavior
        return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
      end
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<Esc>[1;5D>", function()
      if copilot.is_visible() then
        copilot.accept_word() -- Accept only the word
      else
        -- Default Ctrl+Left behavior
        return vim.api.nvim_replace_termcodes("<C-Left>", true, true, true)
      end
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<M-]>", function()
      copilot.next() -- Go to the next suggestion
    end, { silent = true })

    vim.keymap.set("i", "<M-[>", function()
      copilot.prev() -- Go to the previous suggestion
    end, { silent = true })

    vim.keymap.set("i", "<C-]>", function()
      copilot.dismiss() -- Dismiss the suggestion
    end, { silent = true })
  end,
}
