local nvim_lsp = require('lspconfig')
local servers = { 'tsserver', 'rust_analyzer', 'gopls', 'hls', 'eslint', 'terraformls', 'lua_ls' }


local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<C-p>',
    '<cmd> lua vim.lsp.buf.format({filter = function(client) return client.name ~= "tsserver" end, timeout_ms=50000})<CR>',
    bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, v in ipairs(servers) do
  if v == 'lua_ls' then
    nvim_lsp.lua_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
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
      },
    }
  else
    nvim_lsp[v].setup {
      capabilities = capabilities,
      on_attach = on_attach
    }
  end
end

local cmp = require 'cmp'

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
    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})
