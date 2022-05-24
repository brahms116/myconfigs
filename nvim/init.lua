function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode,shortcut,command,{noremap = true, silent = true })
end

vim.g.mapleader = " "

require('plugins')


local o = vim.opt
o.nu = true
o.relativenumber = true
o.tabstop=2
o.softtabstop=2
o.shiftwidth=2
o.expandtab=true
o.ignorecase=true
o.smartcase=true
o.incsearch=true
o.hlsearch=true
o.scrolloff = 16

vim.cmd('set noswapfile')
vim.cmd('hi normal guibg=NONE ctermbg=NONE')


map("i","jj","<ESC>")
map("i","<ESC>","<NOP>")
map("n","<leader>v",":vs<CR>")
map("n","<leader>j",":bp<CR>")
map("n","<leader>k",":bn<CR>")
map("n","<leader>q",":bd<CR>")
map("n","<leader>l","<C-w>l<CR>")
map("n","<leader>h","<C-w>h<CR>")


