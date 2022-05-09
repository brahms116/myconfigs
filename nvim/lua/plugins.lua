local packer = require('packer')

packer.startup(function()
  use "wbthomason/packer.nvim"
  use "EdenEast/nightfox.nvim"
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
  }
 use {'neoclide/coc.nvim', branch="release"}
end)


-- coc
vim.api.nvim_set_keymap("n","<leader>a","<Plug>(coc-codeaction)",{})
vim.api.nvim_set_keymap("n","<leader>d","<Plug>(coc-definition)",{})
map("n","<leader>f",":call CocActionAsync('format')<CR>")
map("n","<C-h>",":call CocActionAsync('doHover')<CR>")



-- Color Scheme
vim.cmd("colorscheme nightfox")



-- telescope
map("n","<C-p>",":Telescope find_files<CR>")
require('telescope').setup{  defaults = { file_ignore_patterns = { "node_modules" }} }






