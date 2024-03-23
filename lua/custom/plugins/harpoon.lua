return {
  'theprimeagen/harpoon',

  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'
    -- Harpoon keymaps
    -- A little bloated, can come back and get it DRY
    vim.keymap.set('n', '<leader>fa', function()
      mark.add_file()
    end, { desc = 'Harpoon add file' })
    vim.keymap.set('n', '<leader>m', function()
      ui.toggle_quick_menu()
    end, { desc = 'Toggle Harpoon Menu' })
    vim.keymap.set('n', '<leader>j', function()
      ui.nav_file(1)
    end, { desc = 'Harpoon File 1' })
    vim.keymap.set('n', '<leader>k', function()
      ui.nav_file(2)
    end, { desc = 'Harpoon File 2' })
    vim.keymap.set('n', '<leader>l', function()
      ui.nav_file(3)
    end, { desc = 'Harpoon File 3' })
    vim.keymap.set('n', '<leader>;', function()
      ui.nav_file(4)
    end, { desc = 'Harpoon File 4' })
  end,
}
