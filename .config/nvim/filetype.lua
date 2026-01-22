if not vim.filetype.match({ filename = ".env.local" }) then
	vim.filetype.add({
		filename = {
			[".env.local"] = "sh",
		},
	})
end
