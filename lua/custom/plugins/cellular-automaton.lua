return {
  'eandrju/cellular-automaton.nvim',

  config = function()
    vim.keymap.set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>', { desc = 'Cellular Automaton: Make it rain' })
    vim.keymap.set('n', '<leader>gol', '<cmd>CellularAutomaton game_of_life<CR>', { desc = 'Cellular Automaton: Game of Life' })
  end,
}
