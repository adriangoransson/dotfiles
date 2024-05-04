local map = function(modes, lhs, rhs)
	vim.keymap.set(modes, lhs, rhs, { silent = true })
end

return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local widgets = require("dap.ui.widgets")

			map("n", "<F5>", dap.continue)
			map("n", "<F10>", dap.step_over)
			map("n", "<F11>", dap.step_into)
			map("n", "<F12>", dap.step_out)
			map("n", "<Leader>db", dap.toggle_breakpoint)
			map("n", "<Leader>dB", dap.set_breakpoint)
			map("n", "<Leader>dr", dap.repl.open)
			map("n", "<Leader>dl", dap.run_last)

			map("n", "<Leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)

			map("n", "<Leader>df", function()
				widgets.centered_float(widgets.frames)
			end)

			map("n", "<Leader>ds", function()
				widgets.centered_float(widgets.scopes)
			end)

			map({ "n", "v" }, "<Leader>dh", widgets.hover)
			map({ "n", "v" }, "<Leader>dp", widgets.preview)
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		opts = {},
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
	},

	{
		"leoluz/nvim-dap-go",
		opts = {},
		dependencies = { "mfussenegger/nvim-dap" },
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
		dependencies = { "mfussenegger/nvim-dap" },
	},
}
