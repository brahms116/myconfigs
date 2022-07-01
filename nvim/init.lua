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
-- vim.cmd('hi normal guibg=NONE ctermbg=NONE')
vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set noshowmode')



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

  for _,v in ipairs(wins) do 
    if table_inc(displayed_buffers,v) then
      num_overlaps = num_overlaps + 1
    else
      table.insert(displayed_buffers,v)
    end
  end

  local diff = #bufs + num_overlaps - #wins
  if diff > 1 then
    table.sort(bufs)
    for _,v in ipairs(bufs) do
      if not table_inc(displayed_buffers,v) then
        vim.api.nvim_buf_call(v,save_buf)
        vim.api.nvim_buf_delete(v,{})
        break
      end
    end
  end
end

vim.api.nvim_create_autocmd({"BufAdd"},{pattern={"*"}, callback = buf_add_cb })

-- Diagnostic config
vim.diagnostic.config({})









