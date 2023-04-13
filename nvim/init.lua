-- =========================
-- David's edtior config
-- =========================


--- @class SetupSettings
--- @field plugins boolean
--- @field lsp boolean

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

end

setup({
  plugins = true,
  lsp = true,
})

require('plugins')

