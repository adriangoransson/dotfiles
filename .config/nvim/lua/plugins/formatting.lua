return {
	"stevearc/conform.nvim",

	config = function()
		local prettier = { "prettierd", "prettier", stop_after_first = true }

		require("conform").setup({
			default_format_opts = {
				timeout_ms = 1000,
				lsp_format = "fallback",
			},

			format_on_save = {},

			formatters_by_ft = {
				javascript = prettier,
				javascriptreact = prettier,
				markdown = prettier,
				svelte = prettier,
				typescript = prettier,
				vue = prettier,
				yaml = prettier,

				go = { "golines", "goimports", "gofumpt" },
				json = { "jq" },
				lua = { "stylua" },
				terraform = { "terraform_fmt" },

				sh = { "trim_whitespace" },

				["_"] = { "use_lsp", "trim_whitespace" },
			},

			formatters = {
				golines = {
					prepend_args = { "--base-formatter=gofmt" }, -- Slow with its default formatter! :(
				},

				gofumpt = {
					prepend_args = { "-extra" },
				},

				-- no-op formatter for use with lsp_format = fallback.
				use_lsp = {
					command = "",
					condition = function()
						return false
					end,
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
