-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Custom Commands ]]

-- Create command :Cpfp to copy the filepath of the current buffer to clipboard
vim.api.nvim_create_user_command('Cpfp', function()
  vim.cmd "let @+ = expand('%:p')"
end, { desc = 'Copy the filepath of the current buffer to the clipboard' })
