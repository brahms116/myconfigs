local packer = require('packer')

packer.startup(function()
  use "wbthomason/packer.nvim"
  use "EdenEast/nightfox.nvim"
  use {'neoclide/coc.nvim', branch="release"}
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'kassio/neoterm'
  use 'savq/melange'
  use 'tpope/vim-commentary'
  use 'nvim-treesitter/nvim-treesitter'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end)


-- terminal
vim.g.neoterm_default_mod="belowright"


-- coc
vim.api.nvim_set_keymap("n","<leader>a","<Plug>(coc-codeaction)",{})
vim.api.nvim_set_keymap("n","<leader>d","<Plug>(coc-definition)",{})
map("n","<C-h>",":call CocActionAsync('doHover')<CR>")



-- Color Scheme
vim.opt.termguicolors = true
vim.cmd("colorscheme melange")


-- fzf
map("n","<C-p>",":Files<CR>")


-- status line
require'lualine'.setup()







