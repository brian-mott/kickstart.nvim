return {
  {
    'tpope/vim-fugitive',
    -- Fugitive keymaps
    vim.keymap.set('n', '<leader>gs', function()
      vim.cmd 'FugitiveFloat'
    end, { desc = 'Git status - Fugitive Floating window' }),

    -- Git log for a file, adds to quickfix list
    vim.keymap.set('n', '<leader>gl', '<cmd>0Gclog<CR>', { desc = '[G]it [l]og for current file, adds to quickfix' }),

    -- from here: https://www.reddit.com/r/neovim/comments/1ag5mk3/fugitive_change_window_to_popup/
    vim.api.nvim_create_user_command('FugitiveFloat', function()
      ui = vim.api.nvim_list_uis()[1]

      local width = math.floor(ui.width * 0.75)
      local height = math.floor(ui.height * 0.75)

      local win_config = {
        relative = 'editor',
        width = width,
        height = height,
        col = (ui.width - width) / 2,
        row = (ui.height - height) / 2,
        -- style = 'minimal',
        focusable = true,
        border = 'rounded',
      }

      if not fugitive_float_bufnr then
        fugitive_float_bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_open_win(fugitive_float_bufnr, true, win_config)
        vim.cmd ':Gedit :'
      elseif vim.api.nvim_win_get_buf(0) == fugitive_float_bufnr then
        vim.api.nvim_command 'hide'
      else
        print '1234'
        vim.api.nvim_open_win(fugitive_float_bufnr, true, win_config)
        vim.cmd ':Gedit :'
      end
    end, {}),
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        -- Gitsigns hunk stage/unstage and reset
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
        vim.keymap.set('n', '<leader>tb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Gitsigns [t]oggle [b]lame' })
        vim.keymap.set({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = 'Gitsigns [h]unk [s]tage' })
        vim.keymap.set({ 'n', 'v' }, '<leader>hu', ':Gitsigns undo_stage_hunk<CR>', { desc = 'Gitsigns [h]unk [u]nstage' })
        vim.keymap.set({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = 'Gitsigns [h]unk [r]eset' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },
}
