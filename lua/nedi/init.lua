-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true


local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

opt.colorcolumn = "80,120"
opt.relativenumber = true
-- opt.noexpandtab = true

autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})
