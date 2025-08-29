local Plugin = {'kyazdani42/nvim-tree.lua'}

Plugin.cmd = {'NvimTreeToggle'}

-- See :help nvim-tree-setup
Plugin.opts = {
  hijack_cursor = false,
  sort_by = "case_sensitive",
  view = {
    width = 30,
    side = "left",
    preserve_window_proportions = true,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        picker = "default",
      },
    },
  },
  on_attach = function(bufnr)
    local bufmap = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
    end

    -- :help nvim-tree.api
    local api = require('nvim-tree.api')

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    bufmap('L', api.node.open.edit, 'Expand folder or go to file')
    bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
    bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
  end
}

function Plugin.init()
  vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

  -- Focus nvim-tree if it's open, otherwise toggle it
  vim.keymap.set('n', '<leader>E', function()
    local api = require('nvim-tree.api')
    local tree_view = require('nvim-tree.view')
    
    if tree_view.is_visible() then
      -- If tree is visible, focus it
      api.tree.focus()
    else
      -- If tree is not visible, open it
      api.tree.open()
    end
  end, { desc = 'Focus nvim-tree or open if closed' })
end

return Plugin