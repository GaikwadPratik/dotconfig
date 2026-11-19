local ensure_installed = {
	"bash",
	"cmake",
	"dockerfile",
	"git_config",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"gotmpl",
	"gowork",
	"javascript",
	"jq",
	"json",
	"lua",
	"make",
	"nginx",
	"passwd",
	"proto",
	"python",
	"regex",
	"rust",
	"ssh_config",
	"terraform",
	"tmux",
	"vim",
	"vimdoc",
	"yaml",
}

local auto_install = true -- Also install a missing parser when opening a supported filesystem
local sync_install = false -- set true to wait for ensure_installed at startup

local function enable_treesitter(buf, lang)
	if not vim.api.nvim_buf_is_loaded(buf) then
		return false
	end

	local bo = vim.bo[buf]
	if bo.buftype ~= "" or vim.treesitter.language.get_lang(bo.filetype) ~= lang then
		return false
	end

	if not vim.treesitter.language.add(lang) then
		return false
	end

	vim.treesitter.start(buf, lang)

	vim.keymap.set({ "n", "x" }, "<CR>", function()
		vim.treesitter.select("parent", vim.v.count1)
	end, { buffer = buf, desc = "Select or expand syntax node" })

	vim.keymap.set("x", "<BS>", function()
		vim.treesitter.select("child", vim.v.count1)
	end, { buffer = buf, desc = "Shrink syntax selection" })

	return true
end

local function can_auto_install(parser)
	local info = parser and parser.install_info
	return info ~= nil and info.path == nil and info.revision ~= nil and parser.tier ~= 4
end

local function install(ts, languages)
	local task = ts.install(languages)
	task:await(vim.schedule_wrap(function(err)
		if err then
			vim.notify("Tree-sitter install failed: " .. tostring(err), vim.log.levels.ERROR)
		end
	end))
	return task
end

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		local catalog = require("nvim-treesitter.parsers")
		local installs = {}

		vim.treesitter.language.register("bash", "sh")
		vim.treesitter.language.register("terraform", "tf")

		local startup = install(ts, ensure_installed)
		for _, lang in ipairs(ensure_installed) do
			installs[lang] = startup
		end

		if sync_install then
			local finished, installed = startup:pwait(300000)
			if not finished or not installed then
				vim.notify("Tree-sitter startup install failed or timed out; see :TSLog.", vim.log.levels.WARN)
			end
		end

		local function on_filetype(ev)
			local lang = vim.treesitter.language.get_lang(ev.match)
			if not lang or vim.bo[ev.buf].buftype ~= "" or enable_treesitter(ev.buf, lang) then
				return
			end

			local task = installs[lang]
			if not task and auto_install and can_auto_install(catalog[lang]) then
				task = install(ts, { lang })
				installs[lang] = task
			end
			if not task then
				return
			end

			task:await(vim.schedule_wrap(function(err)
				if not err then
					ensure_installed(ev.buf, lang)
				end
			end))
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
			callback = on_filetype,
		})
	end,
}
