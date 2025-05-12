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

augroup("lsp", function(au)
	au("LspAttach", "*", function(args)
		local implementations = vim.lsp.buf.implementation
		local references = vim.lsp.buf.references
		local document_symbols = vim.lsp.buf.document_symbol
		local workspace_symbols = vim.lsp.buf.workspace_symbol

		---@module 'snacks'
		if Snacks ~= nil then
			implementations = Snacks.picker.lsp_implementations
			references = Snacks.picker.lsp_references
			document_symbols = Snacks.picker.lsp_symbols
			workspace_symbols = Snacks.picker.lsp_workspace_symbols
		end

		local opts = { noremap = true, silent = true, buffer = args.buf }
		local map = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		vim.api.nvim_create_user_command("InlayHintsToggle", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		end, {})

		vim.lsp.inlay_hint.enable(true)

		map("n", "gD", vim.lsp.buf.declaration)
		map("n", "gd", vim.lsp.buf.definition)
		map("n", "K", vim.lsp.buf.hover)
		map("n", "gi", implementations)
		map("i", "<C-k>", vim.lsp.buf.signature_help)
		map("n", "<leader>D", vim.lsp.buf.type_definition)
		map("n", "<leader>rn", vim.lsp.buf.rename)
		map("n", "gr", references)
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
		map("n", "<leader>e", vim.diagnostic.open_float)
		map("n", "<leader>q", vim.diagnostic.setloclist)
		map("n", "<leader>wq", vim.diagnostic.setqflist)
		map("n", "<leader>so", document_symbols)
		map("n", "<leader>wso", workspace_symbols)
	end)
end)
