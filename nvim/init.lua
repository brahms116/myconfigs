-- =========================
-- David's edtior config
-- =========================

--- @class PluginSettings
--- @field lsp boolean
--- @field treesitter boolean
--- @field copilot boolean

--- @class SetupSettings
--- @field plugins PluginSettings | nil

--- Setup function emcompasses everything to setup
--
--- @param settings SetupSettings
local function setup(settings)
  -- Vim global options --
  vim.g.mapleader = " "

  vim.opt.nu = true
  vim.opt.relativenumber = true
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.incsearch = true
  vim.opt.hlsearch = true
  vim.opt.scrolloff = 16

  vim.cmd('set noswapfile')
  vim.cmd('set clipboard+=unnamedplus')
  vim.cmd('set noshowmode')
  vim.cmd('let g:netrw_keepdir = 0')
  vim.cmd('let g:netrw_winsize = 20')
  vim.cmd('let g:netrw_liststyle = 3')
  vim.cmd('let g:netrw_localcopydircmd = "cp -r" ')

  -- Global key maps --
  local setKeymapOpts = {
    noremap = true,
    silent = true,
  }
  vim.keymap.set('i', 'jj', '<ESC>', setKeymapOpts)
  vim.keymap.set('i', '<ESC>', '<NOP>', setKeymapOpts)
  vim.keymap.set('n', '<leader>v', ':vs<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>j', ':bp<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>k', ':bn<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>q', ':bd<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>l', '<C-w>l<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>h', '<C-w>h<CR>', setKeymapOpts)
  vim.keymap.set('n', '<C-j>', '10j', setKeymapOpts)
  vim.keymap.set('n', '<C-k>', '10k', setKeymapOpts)

  -- Global quickfix keymaps --

  local is_quick_fix_open = false
  --- Toggles the quickfix window
  function Handle_o()
    if is_quick_fix_open then
      is_quick_fix_open = false
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":cclose<CR>", true, true, true))
    else
      is_quick_fix_open = true
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":copen<CR>", true, true, true))
    end
  end

  vim.keymap.set('n', '<leader>n', ':cn<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>p', ':cp<CR>', setKeymapOpts)
  vim.keymap.set('n', '<C-f>', ':grep ', setKeymapOpts)
  vim.keymap.set('n', '<leader>w', ':w<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>o', ':lua Handle_o()<CR>', setKeymapOpts)

  if not settings.plugins then
    return
  end

  -- Plugins --

  local packer = require('packer')
  local use = packer.use

  local function packerStartup()
    -- Essentials --
    use "wbthomason/packer.nvim"
    use 'tpope/vim-commentary'
    use 'tpope/vim-vinegar'
    use 'sainnhe/gruvbox-material'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- nvim cmp --
    use 'hrsh7th/nvim-cmp'
    use 'dcampos/nvim-snippy'
    use 'dcampos/cmp-snippy'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    -- Treesitter --
    if settings.plugins.treesitter then
      use 'nvim-treesitter/nvim-treesitter'
    end

    -- LSP --
    if settings.plugins.lsp then
      use 'neovim/nvim-lspconfig'
      use 'hrsh7th/cmp-nvim-lsp'
    end

    -- Copilot --
    if settings.plugins.copilot then
      use 'github/copilot.vim'
    end
  end
  packer.startup(packerStartup)

  -- Color Scheme
  vim.opt.termguicolors = true
  vim.cmd("let g:gruvbox_material_background = 'soft'")
  vim.cmd("colorscheme gruvbox-material")

  -- status line
  local luaLine = require('lualine')
  luaLine.setup({
    options = {
      theme = 'gruvbox-material'
    }
  })

  -- snippets
  local snippy = require('snippy')
  snippy.setup({
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
  require 'lsp'
end

setup({
  plugins = {
    lsp = true,
    treesitter = true,
    copilot = true,
  },
})
