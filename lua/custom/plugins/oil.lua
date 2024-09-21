return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    opts = {},
  },
  config = function()
    require('oil').setup {
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '<leader>pv', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
