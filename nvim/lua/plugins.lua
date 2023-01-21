local use = require('packer').use
require('packer').startup(function()
  use "wbthomason/packer.nvim"
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'neovim/nvim-lspconfig'
  use 'tpope/vim-commentary'
  use 'nvim-treesitter/nvim-treesitter'
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'sainnhe/gruvbox-material'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'github/copilot.vim'
  use {'jose-elias-alvarez/null-ls.nvim', requires = {'nvim-lua/plenary.nvim'} }
  use 'tpope/vim-vinegar'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end)

-- status line
require'lualine'.setup({
  options = {
    theme = 'gruvbox-material'
  }
})

-- Color Scheme
vim.opt.termguicolors = true
vim.cmd("let g:gruvbox_material_background = 'soft'")
vim.cmd("colorscheme gruvbox-material")

-- fzf

vim.opt.grepprg = "rg --follow --vimgrep --smart-case --no-heading"
map("n","<C-p>",":Files<CR>")

-- snippets
require('snippy').setup({
    mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
        nx = {
            ['<leader>x'] = 'cut_text',
        },
    },
})

-- lsp setup
require'lsp'

