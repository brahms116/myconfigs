function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode,shortcut,command,{noremap = true, silent = true })
end

vim.g.mapleader = " "

require('plugins')
require('global_map')


local o = vim.opt
o.nu = true
o.relativenumber = true
o.tabstop=2
o.softtabstop=2
o.shiftwidth=2
o.expandtab=true
o.ignorecase=true
o.smartcase=true
o.incsearch=true
o.hlsearch=true
o.scrolloff = 16

vim.cmd('set noswapfile')
vim.cmd('hi normal guibg=NONE ctermbg=NONE')
vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set noshowmode')

vim.cmd('let g:netrw_keepdir = 0')
vim.cmd('let g:netrw_winsize = 30')
vim.cmd('let g:netrw_localcopydircmd = "cp -r" ')




function table_inc(table,element)
  for _,v in ipairs(table) do
    if element == v then 
      return true
    end
  end
  return false
end


local last_opened_buff = 0

local save_buf = function()
  vim.cmd(":w")
end

local buf_add_cb = function()

  local bufs = vim.api.nvim_list_bufs()
  local wins = vim.api.nvim_list_wins()
  local displayed_buffers = {}
  local num_overlaps = 0 

  print('bufs')
  print(vim.inspect(bufs))

  local loaded_bufs = {}
  for _,v in ipairs(bufs) do
    local buf_name = vim.api.nvim_buf_get_name(v)
    if vim.api.nvim_buf_is_loaded(v) and #buf_name > 0 then
      table.insert(loaded_bufs, v)
    end
  end

  for _,v in ipairs(wins) do 
    local current_buf = vim.api.nvim_win_get_buf(v)
    if table_inc(displayed_buffers,current_buf) then
      num_overlaps = num_overlaps + 1
    else
      table.insert(displayed_buffers,current_buf)
    end
  end

  print("displayed bufs:")
  print(vim.inspect(displayed_buffers))
--  print("loaded bufs:")
-- print(vim.inspect(loaded_bufs))
  
  local diff = #loaded_bufs + num_overlaps - #wins
  if diff > 1 then
    table.sort(bufs)
    for _,v in ipairs(loaded_bufs) do
      if not table_inc(displayed_buffers,v) then
        print("deleting:")
        print(v)
        vim.api.nvim_buf_call(v,save_buf)
        vim.api.nvim_buf_delete(v,{})
        break
      end
    end
  end
end

-- vim.api.nvim_create_autocmd({"BufAdd"},{pattern={"*"}, callback = buf_add_cb })

-- Diagnostic config
vim.diagnostic.config({})









