local M = {}

function M.setup()
  require("pounce").setup {
    accept_keys = "HTNUEOSALDIBXGPKMFYCWJRQVZ",
    accept_best_key = "<CR>",
    multi_window = true,
  }
end

return M
