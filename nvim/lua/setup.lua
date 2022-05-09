local M = {}

--- @class PluginsEnabled
--- @field enableLsp boolean
--- @field enableCopilot boolean
--- @field enableFzf boolean

--- @class Settings
--- @field enabledPlugins PluginsEnabled | nil

--- @param settings Settings
function M.setup(settings)
  vim.g.mapleader = " "

  vim.opt.nu = true
  vim.opt.relativenumber = true
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = false
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
	vim.opt.cursorline =  true
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

  vim.opt.grepprg = "rg --follow --hidden --vimgrep --smart-case --no-heading"

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
  vim.keymap.set('n', '<C-d>', '10j', setKeymapOpts)
  vim.keymap.set('n', '<C-u>', '10k', setKeymapOpts)

  vim.keymap.set('n', '<leader>o', ':lua Handle_o()<CR>', setKeymapOpts)

  local is_quick_fix_open = false
  function Handle_o()
    if is_quick_fix_open then
      is_quick_fix_open = false
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":cclose<CR>", true, true, true))
    else
      is_quick_fix_open = true
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":vert copen | vertical resize 80 <CR>", true, true, true))
    end
  end

  vim.api.nvim_create_augroup('Enter PHP', { clear = true })
  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.php',
    command = 'setlocal tw=4 sw=4',
    group = 'Enter PHP'
  })

  vim.api.nvim_create_augroup('Enter CPP', { clear = true })
  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { '*.cpp', '*.hpp' },
    callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
    end,
    group = 'Enter CPP'
  })

  if not settings.enabledPlugins then
    return
  end

  -- Plugin configuration (plugins installed via native packages in pack/plugins/start/) --

  vim.g.zenbones_compat = 1

  require('oil').setup()

  -- fzf --
  if settings.enabledPlugins.enableFzf then
    vim.keymap.set('n', '<C-p>', ':Files <CR>', setKeymapOpts)
    vim.keymap.set('n', '<leader>J', ':Rg <CR>', setKeymapOpts)
    vim.keymap.set('n', '<leader>j', ':Rgc <CR>', setKeymapOpts)

    local function rg_fzf_slim(args)
      local command = string.format("rg --column --line-number --glob '!*.pb.go' --glob '!*_test.go' --glob '!**/mocks/**.go' --glob '!*.connect.go' --glob '!*mocks.go' --no-heading --color=always --smart-case %s",
        vim.fn.shellescape(args.args))
      local options = '--delimiter : --nth 4..'
      vim.fn['fzf#vim#grep'](command, 1, { options = options })
    end

    vim.api.nvim_create_user_command(
      'Rgc',
      rg_fzf_slim,
      {
        nargs = '*'
      }
    )

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
  vim.cmd("colorscheme zenbones")
  vim.cmd("set signcolumn=no")

  -- status line
  require('lualine').setup({
    options = {
      theme = 'zenbones',
    }
  })

  -- snippets --
  ---@diagnostic disable-next-line: missing-fields
  require('snippy').setup({
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

  -- bt filetype --
  vim.filetype.add({
    extension = {
      bt = 'bt',
    },
  })

  -- LSP setup via vim.lsp.config + vim.lsp.enable --

  vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })

  vim.lsp.config('clangd', {
    capabilities = { offsetEncoding = 'utf-8' },
  })

  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          }
        },
        telemetry = {
          enable = false,
        },
      },
    }
  })

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
    'pyright',
  }

  vim.lsp.enable(servers)

  -- LspAttach keymaps (replaces on_attach) --
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local bufnr = args.buf

      local function goto_def()
        vim.cmd('normal! mD')
        vim.lsp.buf.definition()
      end

      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', '<leader>d', goto_def, bufopts)
      vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', '<leader>i', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', '<leader>f', function()
        local ft = vim.bo[bufnr].filetype
        if (ft == 'cpp' or ft == 'c') and vim.fn.executable('clang-format') == 1 then
          local cursor = vim.api.nvim_win_get_cursor(0)
          vim.cmd('write')
          vim.cmd('silent !clang-format -i %')
          vim.cmd('edit')
          vim.api.nvim_win_set_cursor(0, cursor)
        else
          vim.lsp.buf.format({ filter = function(client) return client.name ~= 'ts_ls' end, timeout_ms = 50000 })
        end
      end, bufopts)

      vim.keymap.set("n", "]e", function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
      end, bufopts)

      vim.keymap.set("n", "[e", function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end, bufopts)
    end,
  })
end

return M
