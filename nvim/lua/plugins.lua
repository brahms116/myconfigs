
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
vim.g.neoterm_keep_term_open = false
is_term_open = false

local function toggleTerminal()
  if is_term_open then
    is_term_open = false
    return vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":Tclose<CR>",true,true,true))
  else
    is_term_open = true
    return vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":T cd " .. vim.fn.expand('%:p:h').."<CR>",true,true,true))
  end
end

vim.keymap.set("n","<C-t>", toggleTerminal)
map("n","<leader>t",":T ")

 

-- coc
vim.api.nvim_set_keymap("n","<leader>a","<Plug>(coc-codeaction)",{})
vim.api.nvim_set_keymap("n","<leader>d","<Plug>(coc-definition)",{})
map("n","<C-h>",":call CocActionAsync('doHover')<CR>")


-- Color Scheme
vim.opt.termguicolors = true
vim.cmd("colorscheme melange")

-- fzf

vim.opt.grepprg = "rg --follow --vimgrep --smart-case --no-heading"
map("n","<C-p>",":Files<CR>")


-- status line
require'lualine'.setup()







