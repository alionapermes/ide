local overrides = require "custom.nedi.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.nedi.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
    -- require 'kyazdani42/nvim-web-devicons',
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  -- Install a plugin

  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require "custom.nedi.configs.illuminate"
    end,
  },
}

return plugins
