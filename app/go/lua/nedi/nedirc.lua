local M = {}

M.ui = {
  theme = 'nightowl',

  statusline = {
    theme = 'vscode',
    separator_style = 'default',
    overriden_modules = nil,
  },
}

M.plugins = "custom.nedi.plugins"
M.mappings = require "custom.nedi.mappings"

return M
