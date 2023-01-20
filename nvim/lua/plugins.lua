local use = require('packer').use
require('packer').startup(function()
  use "wbthomason/packer.nvim"
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use "rebelot/kanagawa.nvim"
  use 'neovim/nvim-lspconfig'
  use 'tpope/vim-commentary'
  use 'nvim-treesitter/nvim-treesitter'
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'github/copilot.vim'
  use {'jose-elias-alvarez/null-ls.nvim', requires = {'nvim-lua/plenary.nvim'} }
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

-- Color Scheme
vim.opt.termguicolors = true
vim.cmd("colorscheme kanagawa")

-- fzf

vim.opt.grepprg = "rg --follow --vimgrep --smart-case --no-heading"
map("n","<C-p>",":Files<CR>")

-- status line
require'lualine'.setup()

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

