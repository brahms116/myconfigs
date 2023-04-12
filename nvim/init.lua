function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

vim.g.mapleader = " "

require('plugins')
require('global_map')


local o = vim.opt
o.nu = true
o.relativenumber = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true
o.scrolloff = 16

vim.cmd('set noswapfile')
vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set noshowmode')

vim.cmd('let g:netrw_keepdir = 0')
vim.cmd('let g:netrw_winsize = 20')
vim.cmd('let g:netrw_liststyle = 3')
vim.cmd('let g:netrw_localcopydircmd = "cp -r" ')

-- Diagnostic config
vim.diagnostic.config({})
vim.diagnostic.config({})
