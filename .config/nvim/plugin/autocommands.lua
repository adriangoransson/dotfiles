local augroup = require("util").augroup
local wd = require("plugin.workingdir")

augroup("highlight_yank", function(au)
	au("TextYankPost", "*", function()
		vim.highlight.on_yank({ higroup = "Search", timeout = 300 })
	end)
end)

augroup("wd_title", function(au)
	au({ "BufEnter", "DirChanged" }, "*", function()
		vim.o.titlestring = "nvim (" .. wd.get(2) .. ")"
	end)

	au("VimSuspend", "*", function()
		vim.o.title = false
	end)

	au("VimResume", "*", function()
		vim.o.title = true
	end)
end)
