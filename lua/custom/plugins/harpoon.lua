return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon' -- Add current file to Harpoon

    harpoon:setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add file to Harpoon' })

    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set('n', '<C-1>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<C-2>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<C-3>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<C-4>', function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end)
    --
    --
  end,
}
