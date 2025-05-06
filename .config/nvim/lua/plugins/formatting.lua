return {
	"stevearc/conform.nvim",

	config = function()
		local prettier = { "prettierd", "prettier", stop_after_first = true }

		require("conform").setup({
			format_on_save = {},

			formatters_by_ft = {
				javascript = prettier,
				javascriptreact = prettier,
				markdown = { "injected", "prettier" },
				svelte = prettier,
				typescript = prettier,
				vue = prettier,
				yaml = prettier,

				go = { "gofumpt", "goimports", "golines", lsp_format = "first" },
				json = { "jq" },
				lua = { "stylua" },
				terraform = { "terraform_fmt" },

				["_"] = { "trim_whitespace", lsp_format = "prefer" },
			},

			formatters = {
				golines = {
					prepend_args = { "--base-formatter=gofmt" }, -- Slow with its default formatter! :(
				},

				gofumpt = {
					prepend_args = { "-extra" },
				},
			},
		})

		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end

			require("conform").format({
				timeout_ms = 2000,
				range = range,
			})
		end, { range = true })
	end,

	init = function()
		vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
	end,
}
