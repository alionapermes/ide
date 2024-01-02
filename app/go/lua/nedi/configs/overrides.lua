local M = {}

M.nvimtree = {
  git = {
    enable = true,
  },

  view = {
    width = 50,
  },

  filters = {
    dotfiles = false,
    custom = {'^.git$'},
    git_ignored = false,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.telescope = {
  defaults = {
    file_ignore_patterns = {
      'node_modules',
      '.git',
    }
  },

  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
    },
  }
}

return M
