-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
  config = function ()
    require('todo-comments').setup()

    vim.keymap.set('n', '<leader>st', '<CMD>TodoTelescope<CR>', { desc = 'Open all todos' })
  end,
}
