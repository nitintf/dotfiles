local M = {}

function M.setup()
	local plugin = require("alpha")

	plugin.setup(require("alpha.themes.dashboard").config)
end

return M
