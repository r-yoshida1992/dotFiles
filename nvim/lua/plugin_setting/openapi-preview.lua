return {
	"nvim-lua/plenary.nvim",
	cmd = { "OpenApiPreview", "OpenApiPreviewStop", "OpenApiPreviewRestart" },
	config = function()
		local preview_html = vim.fn.stdpath("cache") .. "/openapi-preview.html"

		local function stop_preview()
			vim.notify("OpenAPI preview uses a static HTML file; close the browser tab to stop viewing it")
		end

		local function preview_current_file()
			local file = vim.fn.expand("%:p")
			if file == "" or vim.fn.filereadable(file) == 0 then
				vim.notify("Open an OpenAPI YAML/JSON file before starting preview", vim.log.levels.ERROR)
				return
			end

			local cmd = {
				"redocly",
				"build-docs",
				file,
				"--output",
				preview_html,
				"--disableGoogleFont",
			}

			local output = vim.fn.system(cmd)
			if vim.v.shell_error ~= 0 then
				vim.notify(output, vim.log.levels.ERROR)
				return
			end

			vim.fn.jobstart({ "open", preview_html }, { detach = true })
			vim.notify("OpenAPI preview generated: " .. preview_html)
		end

		vim.api.nvim_create_user_command("OpenApiPreview", preview_current_file, {})
		vim.api.nvim_create_user_command("OpenApiPreviewStop", stop_preview, {})
		vim.api.nvim_create_user_command("OpenApiPreviewRestart", preview_current_file, {})
	end,
}
