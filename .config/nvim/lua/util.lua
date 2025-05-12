local M = {}

M.augroup = function(name, au_add)
	local id = vim.api.nvim_create_augroup(name, { clear = true })

	au_add(function(event, pattern, callback, opts)
		opts = vim.tbl_extend("force", opts or {}, {
			group = id,
			pattern = pattern,
			callback = callback,
		})

		vim.api.nvim_create_autocmd(event, opts)
	end)
end

return M
