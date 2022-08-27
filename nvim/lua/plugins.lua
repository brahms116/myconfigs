
local use = require('packer').use
require('packer').startup(function()
  use "wbthomason/packer.nvim"
  use "EdenEast/nightfox.nvim"
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'kassio/neoterm'
  use 'savq/melange'
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
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
--  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
--  use 'L3MON4D3/LuaSnip'
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

vim.keymap.set("n","<C-t>", toggleTerminal)
map("n","<leader>t",":T ")

 


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

-- markdown preview
vim.g.mkdp_open_to_the_world = 1
vim.g.mkdp_open_ip = "127.0.0.1"
vim.g.mkdp_port = 8080

vim.g.empty_func = function()
end

vim.cmd([[
  function! g:Empty(url)
  endfunction
  ]])

vim.g.mkdp_browserfunc="empty"




