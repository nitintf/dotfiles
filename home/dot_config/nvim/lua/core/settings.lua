vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

-- Display options only. vscode-neovim force-sets wrap, signcolumn and number in
-- runtime/lua/vscode/force-options.lua ("options which may break the extension")
-- and re-forces them on VimEnter/BufEnter/FileType, so setting them here just
-- fights the extension and risks desyncing the buffer from the VSCode document.
if not vim.g.vscode then
  vim.opt.number = true
  vim.opt.mouse = 'a'
  vim.opt.wrap = true
  vim.opt.breakindent = true
  vim.opt.signcolumn = 'yes'
  vim.opt.termguicolors = true
end
