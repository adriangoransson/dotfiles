local ts = require("nvim-treesitter.ts_utils")

-- gomodifytags has an -offset parameter too, but that only works from within
-- the struct tags.
local struct_lines = function()
	local node = ts.get_node_at_cursor()
	while node do
		if node:type() == "type_spec" or node:type() == "struct_type" then
			break
		end

		node = node:parent()
	end

	if not node then
		error("No type declaration at cursor position.")
	end

	if node:type() == "type_spec" then
		if node:child(1):type() ~= "struct_type" then
			error("No struct declaration at cursor position.")
		end
	end

	local start_line, _, end_line, _ = node:range()

	return start_line + 1, end_line + 1
end

local modify_tags = function(tag_name, transform, args)
	local start_line, end_line = args["line1"], args["line2"]
	if args["count"] == -1 then
		start_line, end_line = struct_lines()
	end

	local tag_opt = "-add-tags"
	if args["bang"] then
		tag_opt = "-remove-tags"
	end

	local filename = vim.fn.expand("%:p:gs!\\!/!")
	local cmd = {
		"gomodifytags",
		"-file",
		filename,
		tag_opt,
		tag_name,
		"-transform",
		transform,
		"-line",
		start_line .. "," .. end_line,
		"-format",
		"json",
		"-skip-unexported",
	}

	local modified = vim.api.nvim_buf_get_option(0, "modified")
	if modified then
		table.insert(cmd, "-modified")
	end

	local job_id = vim.fn.jobstart(cmd, {
		on_stdout = function(_, data, _)
			local response = vim.fn.json_decode(data)
			vim.api.nvim_buf_set_lines(
				0,
				response["start"] - 1,
				response["start"] - 1 + #response.lines,
				false,
				response.lines
			)
		end,
	})

	if modified then
		local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
		vim.fn.chansend(job_id, filename .. "\n" .. #content .. "\n" .. content)
		vim.fn.chanclose(job_id, "stdin")
	end
end

return {
	struct_lines = struct_lines,
	modify_tags = modify_tags,
}
