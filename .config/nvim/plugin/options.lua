-- Neovim specific options.

vim.o.inccommand = "nosplit"
vim.o.title = true
vim.opt.diffopt:append({ "linematch:60" })

local function augroup(name, au_add)
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

augroup("highlight_yank", function(au)
	au("TextYankPost", "*", function()
		vim.highlight.on_yank({ higroup = "Search", timeout = 300 })
	end)
end)

augroup("wd_title", function(au)
	au({ "BufEnter", "DirChanged" }, "*", function()
		vim.o.titlestring = "nvim (" .. require("plugin.workingdir").get(2) .. ")"
	end)

	au("VimSuspend", "*", function()
		vim.o.title = false
	end)

	au("VimResume", "*", function()
		vim.o.title = true
	end)
end)
