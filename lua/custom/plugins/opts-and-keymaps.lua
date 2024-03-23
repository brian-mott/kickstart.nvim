-- Using this to set expand within brackets
-- might be a better way with functions but this works for now
vim.cmd 'let delimitMate_expand_cr = 2'

-- neo-tree keymaps
vim.keymap.set('n', '<leader>e', '<cmd>:Neotree<CR>', { desc = 'Open Neotree' })

-- Set highlight on search
vim.o.hlsearch = false

-- Color column at 80 characters
vim.o.colorcolumn = '120'

-- Smart indent
vim.o.smartindent = true
vim.o.cindent = true

-- Other tab settings
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Move lines around while in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected line(s) up' })
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv", { desc = 'Move selected line(s) down' })

-- Quickfix keymaps
vim.keymap.set('n', '<leader>qf', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd 'cclose'
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd 'copen'
  end
end, { desc = 'Open [Q]uick[f]ix' })

vim.keymap.set('n', '<leader>qn', '<cmd>cnext<CR>', { desc = '[Q]uickfix [N]ext' })
vim.keymap.set('n', '<leader>qp', '<cmd>cprevious<CR>', { desc = '[Q]uickfix [P]revious' })

-- Centered page scroll
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down, centered cursor' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Page up, centered cursor' })

-- Cycle search terms with cursor centered
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search term with centered cursor' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search term with centered cursor' })

-- Empty register paste
vim.keymap.set('n', '<leader>p', '"_dP', { desc = '[p]aste, delete to empty register' })

-- Python if __name__ == '__main__'
vim.keymap.set('n', '<leader>ma', "iif __name__ == '__main__':<CR>", { desc = 'Python if __name__ == __main__' })

vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = false, lsp_fallback = true, range = range }
end, { range = true })

vim.keymap.set({ 'n', 'v' }, '<leader>ff', ':Format<CR>', { desc = 'Format with Conform' })
