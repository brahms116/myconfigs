
map("i","jj","<ESC>")
map("i","<ESC>","<NOP>")
map("n","<leader>v",":vs<CR>")
map("n","<leader>j",":bp<CR>")
map("n","<leader>k",":bn<CR>")
map("n","<leader>q",":bd<CR>")
map("n","<leader>l","<C-w>l<CR>")
map("n","<leader>h","<C-w>h<CR>")

function is_backspace_clear()
  local position = vim.api.nvim_win_get_cursor(0)
  local col = position[2]
  if col == 0 then
    return true
  end
  local char = string.sub(vim.api.nvim_get_current_line(),col,col)
  if string.match(char,"%s") then
     return true  
   else
     return false
   end
end 

function handle_tab()
  if vim.fn['pumvisible']() and not is_backspace_clear() then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("\<C-n>",true,true,true))
  else
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("\<TAB>",true,true,true),"n")
  end
end
vim.keymap.set('i','<TAB>',handle_tab)







