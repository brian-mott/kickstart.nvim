return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        columns = { 'icon' },
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set('n', '<leader>o', '<CMD>Oil<CR>', { desc = '[O]il open parent directory' })

      -- Open parent directory in floating window
      vim.keymap.set('n', '<leader>of', require('oil').toggle_float, { desc = '[O]il open [f]loating window' })
    end,
  },
}
