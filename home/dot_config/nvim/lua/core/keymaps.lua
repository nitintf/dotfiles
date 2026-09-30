-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^')
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'gy', '"+y') -- copy
vim.keymap.set({'n', 'x'}, 'gp', '"+p') -- paste

-- Delete text
vim.keymap.set({'n', 'x'}, 'x', '"_x')
vim.keymap.set({'n', 'x'}, 'X', '"_d')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')

if vim.g.vscode then
  -- Embedded in VSCode: buffers, windows and the file tree all belong to VSCode.
  -- Driving them with :bdelete / :buffer / <C-w> deletes the nvim buffer while
  -- VSCode keeps the document open, which desyncs the two and makes the next
  -- cursor sync fail with "nvim_win_set_cursor: Invalid cursor line: out of range".
  -- Required lazily so the map still defines if the extension runtime is not
  -- on rtp yet at startup.
  local function action(name)
    return function() require('vscode').action(name) end
  end

  -- Window navigation
  vim.keymap.set('n', '<C-h>', action('workbench.action.navigateLeft'))
  vim.keymap.set('n', '<C-j>', action('workbench.action.navigateDown'))
  vim.keymap.set('n', '<C-k>', action('workbench.action.navigateUp'))
  vim.keymap.set('n', '<C-l>', action('workbench.action.navigateRight'))

  -- Editor (tab) navigation
  vim.keymap.set('n', '<Tab>', action('workbench.action.nextEditorInGroup'))
  vim.keymap.set('n', '<S-Tab>', action('workbench.action.previousEditorInGroup'))
  vim.keymap.set('n', '<leader>x', action('workbench.action.closeActiveEditor'))
  vim.keymap.set('n', '<leader>bq', action('workbench.action.closeActiveEditor'))
  vim.keymap.set('n', '<leader>bl', action('workbench.action.openPreviousRecentlyUsedEditorInGroup'))

  -- File tree (nvim-tree is not loaded here)
  vim.keymap.set('n', '<leader>e', action('workbench.action.toggleSidebarVisibility'))
  vim.keymap.set('n', '<leader>E', action('workbench.files.action.focusFilesExplorer'))

  -- Pickers (telescope is not loaded here)
  vim.keymap.set('n', '<leader>?', action('workbench.action.openRecent'))
  vim.keymap.set('n', '<leader><space>', action('workbench.action.showAllEditors'))
  vim.keymap.set('n', '<leader>ff', action('workbench.action.quickOpen'))
  vim.keymap.set('n', '<leader>fg', action('workbench.action.findInFiles'))
  vim.keymap.set('n', '<leader>fd', action('workbench.actions.view.problems'))
  vim.keymap.set('n', '<leader>fs', action('actions.find'))
else
  -- Window navigation (Ctrl+h/j/k/l to switch windows)
  vim.keymap.set('n', '<C-h>', '<C-w>h')
  vim.keymap.set('n', '<C-j>', '<C-w>j')
  vim.keymap.set('n', '<C-k>', '<C-w>k')
  vim.keymap.set('n', '<C-l>', '<C-w>l')

  -- Buffer/tab navigation
  vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>')
  vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>')
  vim.keymap.set('n', '<leader>x', '<cmd>bdelete<cr>')
  vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>')
  vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>')
end
