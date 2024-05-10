local M = {}

function M.setup()
	local plugin = require("colorizer")

	plugin.setup({
		"*",
	})
end

return M
