-- =========================
-- David's edtior config
-- =========================

--- @class PluginSettings
--- @field lsp boolean
--- @field treesitter boolean
--- @field copilot boolean
--- @field fzf boolean

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
  vim.opt.scrolloff = 4

  vim.cmd('set noswapfile')
  vim.cmd('set clipboard+=unnamedplus')
  vim.cmd('set noshowmode')
  vim.cmd('let g:netrw_keepdir = 0')
  vim.cmd('let g:netrw_winsize = 20')
  vim.cmd('let g:netrw_liststyle = 4')
  vim.cmd('let g:netrw_localcopydircmd = "cp -r" ')


  -- rg?? --
  vim.opt.grepprg = "rg --follow --hidden --vimgrep --smart-case --no-heading"

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
  vim.keymap.set('n', '<C-j>', '20j', setKeymapOpts)
  vim.keymap.set('n', '<C-k>', '20k', setKeymapOpts)
  vim.keymap.set('v', '<C-j>', '20j', setKeymapOpts)
  vim.keymap.set('v', '<C-k>', '20k', setKeymapOpts)
  vim.keymap.set('n', '<C-p>', ':ls<CR>:b<Space>', setKeymapOpts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', 'cp', ':let @+=expand("%:p")<CR>', setKeymapOpts)
  vim.keymap.set('n', '<F3>', ':set invwrap<CR>', setKeymapOpts)

  -- Global quickfix keymaps --

  local is_quick_fix_open = false
  --- Toggles the quickfix window
  function Handle_o()
    if is_quick_fix_open then
      is_quick_fix_open = false
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":cclose<CR>", true, true, true))
    else
      is_quick_fix_open = true
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":vert copen | vertical resize 80 <CR>", true, true, true))
    end
  end

  vim.keymap.set('n', '<leader>n', ':cn<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>p', ':cp<CR>', setKeymapOpts)
  vim.keymap.set('n', '<C-f>', ':grep ', setKeymapOpts)
  vim.keymap.set('n', '<leader>w', ':w<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>o', ':lua Handle_o()<CR>', setKeymapOpts)

  -- php setup --
  vim.api.nvim_create_augroup('Enter PHP', { clear = true })
  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.php',
    command = 'setlocal tw=4 sw=4',
    group = 'Enter PHP'
  })

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
    use 'sainnhe/gruvbox-material'
    use 'sainnhe/everforest'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
      'stevearc/oil.nvim',
      config = function() require('oil').setup() end
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

    if settings.plugins.fzf then
      use 'junegunn/fzf'
      use 'junegunn/fzf.vim'
    end

    use 'prettier/vim-prettier'
    use 'tpope/vim-fugitive'
    use "sindrets/diffview.nvim"
  end
  packer.startup(packerStartup)


  -- Oil keymaps --
  vim.keymap.set('n', '-', require('oil').open, setKeymapOpts)


  -- Color Scheme
  vim.opt.termguicolors = true
  vim.cmd("let g:gruvbox_material_background = 'soft'")
  vim.cmd("colorscheme gruvbox-material")
  vim.cmd("hi! normal guibg=000000")
  vim.cmd("hi! nontext guibg=000000")
  vim.cmd("hi! endofbuffer guibg=000000")
  vim.cmd("hi! normalnc guibg=000000")

  -- status line
  local luaLine = require('lualine')
  luaLine.setup({
    options = {
      theme = 'gruvbox-material'
    }
  })

  -- snippets --
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

  -- nvim-cmp --

  local cmp = require('cmp')
  local cmpSources = {
    { name = 'snippy' },
  }
  if settings.plugins.lsp then
    table.insert(cmpSources, { name = 'nvim_lsp' })
  end
  cmp.setup({
    snippet = {
      expand = function(args)
        require('snippy').expand_snippet(args.body)
      end
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources(cmpSources, {
      { name = 'buffer' },
    })
  })

  -- fzf --
  vim.keymap.set('n', '<C-p>', ':Files <CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>h', ':History<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>m', ':Marks<CR>', setKeymapOpts)

  -- treesitter --
  if settings.plugins.treesitter then
    require('nvim-treesitter.configs').setup({
      ensure_installed = { "lua", "terraform", "rust", "json", "html", "css", "typescript", "vim", "javascript" },
      indent = {
        enable = true
      },
      highlight = {
        enable = true,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      },
    })
  end

  if not settings.plugins.lsp then
    return
  end

  -- lsp setup --

  local nvim_lsp = require('lspconfig')
  local servers = {
    'tsserver',
    'rust_analyzer',
    'gopls',
    'hls',
    'eslint',
    'terraformls',
    'elmls',
    'lua_ls',
    'taplo',
    'intelephense',
    'clangd',
    'jsonls',
    'cssls',
    'html'
  }


  local on_attach = function(_, bufnr)

    -- Custom goto def with marker helper func
    local function goto_def()
      -- set the marker D
      vim.cmd('normal! mD')
      vim.lsp.buf.definition()
    end


    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>d', goto_def, bufopts)
    vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>f',
      '<cmd> lua vim.lsp.buf.format({filter = function(client) return client.name ~= "tsserver" end, timeout_ms=50000})<CR>',
      bufopts)
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  for _, v in ipairs(servers) do
    local params = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    if v == 'clangd' then
      capabilities.offset_encoding = "utf-8"
    end

    if v == 'lua_ls' then
      params['settings'] = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      }
    end

    nvim_lsp[v].setup(params)
  end
end

setup({
  plugins = {
    lsp = true,
    treesitter = true,
    copilot = true,
    fzf = true,
  },
})
