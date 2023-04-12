map("i","jj","<ESC>")
map("i","<ESC>","<NOP>")
map("n","<leader>v",":vs<CR>")
map("n","<leader>j",":bp<CR>")
map("n","<leader>k",":bn<CR>")
map("n","<leader>q",":bd<CR>")
map("n","<leader>l","<C-w>l<CR>")
map("n","<leader>h","<C-w>h<CR>")
map("n","<C-j>","10j")
map("n","<C-k>","10k")


local is_quick_fix_open = false
function handle_o()
  if is_quick_fix_open then
    is_quick_fix_open = false
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":cclose<CR>",true,true,true))
  else 
    is_quick_fix_open = true
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":copen<CR>",true,true,true))
  end
end

map('n','<leader>n',':cn<CR>')
map('n','<leader>p',':cp<CR>')
map('n','<leader>f',':Lexplore %:p:h<CR>')
map('n','<C-f>',':grep ')

-- Save on format, should remove this if lsp is not configured
map('n','<leader>w',':w<CR>')

map('n','<leader>o',':lua handle_o()<CR>')








