local format_opts = {
	timeout_ms = 500,
	lsp_fallback = true,
}

return {
	"stevearc/conform.nvim",

	config = function()
		local prettier = { { "prettierd" }, { "prettier" } }

		require("conform").setup({
			format_on_save = format_opts,

			formatters_by_ft = {
				lua = { "stylua" },

				typescript = prettier,
				javascript = prettier,
				javascriptreact = prettier,
				svelte = prettier,
				vue = prettier,
				markdown = prettier,

				json = { "jq" },
				terraform = { "terraform_fmt" },
				go = { "golines", "goimports", "gofumpt" },

				["_"] = { "use_lsp", "trim_whitespace" },
			},

			formatters = {
				golines = {
					prepend_args = { "--base-formatter=gofmt" }, -- Slow with its default formatter! :(
				},

				gofumpt = {
					prepend_args = { "-extra" },
				},

				-- no-op formatter for use with lsp_fallback.
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

			local opts = vim.tbl_extend("force", format_opts, { range = range })
			require("conform").format(opts)
		end, { range = true })
	end,

	init = function()
		vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
	end,
}
