-- =========================
-- David's edtior config
-- =========================

local M = {}

--- @class PluginsEnabled
--- @field enableLsp boolean
--- @field enableCopilot boolean
--- @field enableFzf boolean

--- @class Settings
--- @field enabledPlugins PluginsEnabled | nil

--- Setup function emcompasses everything to setup
--- @param settings Settings
function M.setup(settings)
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
  vim.opt.scrolloff = 999
  vim.opt.wrap = false

  vim.cmd('set noswapfile')
  vim.cmd('set clipboard+=unnamedplus')
  vim.cmd('set noshowmode')
  vim.cmd('let g:netrw_keepdir = 0')
  vim.cmd('let g:netrw_winsize = 20')
  vim.cmd('let g:netrw_liststyle = 4')
  vim.cmd('let g:netrw_localcopydircmd = "cp -r" ')
  vim.cmd('let g:c_syntax_for_h = 1')

  -- Sets the :grep to use rg --
  vim.opt.grepprg = "rg --follow --hidden --vimgrep --smart-case --no-heading"

  -- Global key maps --
  local setKeymapOpts = {
    noremap = true,
    silent = true,
  }

  vim.keymap.set('i', 'jj', '<ESC>', setKeymapOpts)
  vim.keymap.set('i', '<ESC>', '<NOP>', setKeymapOpts)
  vim.keymap.set('n', '<leader>v', ':vs<CR>', setKeymapOpts)
  vim.keymap.set('n', '<C-p>', ':ls<CR>:b<Space>', setKeymapOpts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', 'cp', ':let @+=expand("%:p")<CR>', setKeymapOpts)
  vim.keymap.set('n', '<F3>', ':set invwrap<CR>', setKeymapOpts)
  vim.keymap.set('n', '<C-r>', ':%s/', setKeymapOpts)
  vim.keymap.set('n', '<leader>n', ':cn<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>p', ':cp<CR>', setKeymapOpts)
  vim.keymap.set('n', '<C-f>', ':grep -F "', setKeymapOpts)
  vim.keymap.set('n', '<leader>w', ':w<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>W', ':wall<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>q', ':bd<CR>', setKeymapOpts)
  vim.keymap.set('n', '<leader>Q', ':qall<CR>', setKeymapOpts)

  -- Global quickfix keymaps --
  vim.keymap.set('n', '<leader>o', ':lua Handle_o()<CR>', setKeymapOpts)

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

  -- php setup --
  vim.api.nvim_create_augroup('Enter PHP', { clear = true })
  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.php',
    command = 'setlocal tw=4 sw=4',
    group = 'Enter PHP'
  })

  if not settings.enabledPlugins then
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
    use { "ellisonleao/gruvbox.nvim" }
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

    -- LSP --
    if settings.enabledPlugins.enableLsp then
      use 'neovim/nvim-lspconfig'
      use 'hrsh7th/cmp-nvim-lsp'

      use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
      }
      use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
      }
    end

    -- Copilot --
    if settings.enabledPlugins.enableCopilot then
      use 'github/copilot.vim'
    end

    if settings.enabledPlugins.enableFzf then
      use 'junegunn/fzf'
      use 'junegunn/fzf.vim'
    end

    use 'prettier/vim-prettier'
    use 'tpope/vim-fugitive'
  end
  packer.startup(packerStartup)

  -- fzf --
  if settings.enabledPlugins.enableFzf then
    vim.keymap.set('n', '<C-p>', ':Files <CR>', setKeymapOpts)
    vim.keymap.set('n', '<leader>j', ':Rg <CR>', setKeymapOpts)

    local function rg_fzf(args)
      local command = string.format("rg --column --line-number --no-heading --color=always --smart-case %s",
        vim.fn.shellescape(args.args))
      local options = '--delimiter : --nth 4..'
      vim.fn['fzf#vim#grep'](command, 1, { options = options })
    end

    vim.api.nvim_create_user_command(
      'Rg',
      rg_fzf,
      {
        nargs = '*'
      }
    )
  end


  -- Oil keymaps --
  vim.keymap.set('n', '-', require('oil').open, setKeymapOpts)


  -- Color Scheme
  vim.opt.termguicolors = true

  vim.o.background = "light"
  vim.cmd("colorscheme gruvbox")

  -- clear signs --
  vim.cmd("set signcolumn=no")

  -- status line
  local luaLine = require('lualine')
  luaLine.setup({
    options = {
      theme = 'gruvbox_light'
    }
  })

  -- snippets --
  local snippy = require('snippy')

  ---@diagnostic disable-next-line: missing-fields
  snippy.setup({
    mappings = {
      is = {
        ['<leader><Tab>'] = 'expand_or_advance',
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
  if settings.enabledPlugins.enableLsp then
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

  if not settings.enabledPlugins.enableLsp then
    return
  end

  -- Add the bt filetype --
  vim.filetype.add({
    extension = {
      bt = 'bt',
    },
  })

  -- lsp setup --
  local nvim_lsp = require('lspconfig')
  local configs = require 'lspconfig.configs'
  if not configs.bt_lsp then
    configs.bt_lsp = {
      default_config = {
        name = 'bt-lsp',
        cmd = { '/Users/david/dev/between/bt-lsp' },
        root_dir = nvim_lsp.util.root_pattern('.git'),
        filetypes = { 'bt' },
      },
    }
  end

  local servers = {
    'bt_lsp',
    'ts_ls',
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
    'html',
    'csharp_ls',
  }


  local on_attach = function(_, bufnr)
    -- Custom goto def with marker helper func
    local function goto_def()
      -- set the marker D
      vim.cmd('normal! mD')
      vim.lsp.buf.definition()
    end


    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
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
      '<cmd> lua vim.lsp.buf.format({filter = function(client) return client.name ~= "ts_ls" end, timeout_ms=50000})<CR>',
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
            -- library = vim.api.nvim_get_runtime_file("", true),
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

  require 'nvim-treesitter.configs'.setup {
    modules = {},
    sync_install = true,
    auto_install = false,
    ensure_installed = {},
    ignore_install = {},
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          ["ls"] = "@assignment.lhs",
          ["rs"] = "@assignment.rhs",

          ["aa"] = "@assignment.outer",
          ["ia"] = "@assignment.inner",

          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",

          ["aC"] = "@call.outer",
          ["iC"] = "@call.inner",

          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",

          ["af"] = "@function.outer",
          ["if"] = "@function.inner",

          ["ac"] = "@class.outer",
          -- You can optionally set descriptions to the mappings (used in the desc parameter of
          -- nvim_buf_set_keymap) which plugins like which-key display
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          -- You can also use captures from other query groups like `locals.scm`
          ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V',  -- linewise
          ['@class.outer'] = 'V'
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true or false
        include_surrounding_whitespace = false,
      },
    },
  }
end

return M
