local null_ls = require "null-ls"

local format = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

local sources = {
  format.stylua,
  -- format.goimports_reviser,
  format.goimports,
  format.golines,
  format.gofmt,
  format.golangci_lint.with {
    filetypes = { "go", "gomod" },
    command = "golangci-lint-langserver",
    args = { "run", "--out-format", "json" },
  },

  lint.shellcheck,
  lint.buf, -- protobuf
  -- lint.golangci_lint,
  -- lint.staticcheck, -- go

  actions.impl,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
