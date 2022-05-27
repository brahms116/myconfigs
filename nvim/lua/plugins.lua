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


function is_backspace_clear()
  local position = vim.api.nvim_win_get_cursor(0)
  local col = position[2]
  if col == 0 then
    return true
  end
  local char = string.sub(vim.api.nvim_get_current_line(),col,col)
  if string.match(char,"%s") then
     return true  
   else
     return false
   end
end 



function handle_tab()
  if vim.fn['pumvisible']() and not is_backspace_clear() then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("\<C-n>",true,true,true))
  else
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("\<TAB>",true,true,true),"n")
  end
end
vim.keymap.set('i','<TAB>',handle_tab, {slient=true})

-- Color Scheme
vim.opt.termguicolors = true
vim.cmd("colorscheme melange")


-- fzf
map("n","<C-p>",":Files<CR>")


-- status line
require'lualine'.setup()







