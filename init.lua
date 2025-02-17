-- terminal settings
local powershell_options = {
	shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
	shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
	shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
	shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
	shellquote = "",
	shellxquote = "",
}

for option, value in pairs(powershell_options) do
	vim.opt[option] = value
end

local opt = vim.opt

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.mouse = "a"
opt.laststatus = 2
opt.showcmd = true
opt.showmode = true
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.winminwidth = 5
opt.textwidth = 99
opt.expandtab = true
opt.shiftwidth = 4
opt.shiftround = true
opt.tabstop = 4
opt.termguicolors = true
opt.hidden = true
opt.undofile = true
opt.undolevels = 10000
opt.secure = true
opt.exrc = true
opt.foldmethod = "indent"
opt.foldlevel = 99

-- Key mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")

-- minimize terminal split
vim.keymap.set("n", "<C-g>", "3<C-w>_")

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.keymap.set("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move up/down editor lines
vim.keymap.set("n", "j", "gj", { remap = true })
vim.keymap.set("n", "k", "gk", { remap = true })

-- Insert newline without entering insert mode
vim.keymap.set("n", "<S-Enter>", "O<Esc>")
vim.keymap.set("n", "<CR>", "o<Esc>")

-- Searching
vim.keymap.set("n", "/", "/\v", { remap = true })
vim.keymap.set("v", "/", "/\v", { remap = true })
vim.keymap.set({ "n", "v", "i" }, "<leader><space>", ":let @/=''<cr>")
vim.keymap.set("n", "<F3>", ":set hlsearch!<CR>", { remap = true })

-- Remap help key.
vim.keymap.set("n", "<C-space>", "za", { remap = true })
vim.keymap.set("i", "<F1>", "<ESC>:set invfullscreen<CR>a", { remap = true })
vim.keymap.set({ "n", i }, "<F1>", ":set invfullscreen<CR>", { remap = true })
vim.keymap.set("n", "/", "/\v")

-- Brace completion
vim.keymap.set("i", "{", "{}<Esc>i", { remap = true })
vim.keymap.set("i", "(", "()<Esc>i", { remap = true })
vim.keymap.set("i", "[", "[]<Esc>i", { remap = true })

-- Formatting
vim.keymap.set("n", "<leader>q", "gqip")

-- Remap ^] to gä
vim.keymap.set("n", "^]", "gä")
vim.keymap.set({ "n", "v", "i" }, "gä", "<C-]>")

-- Or use your leader key + l to toggle on/off
vim.keymap.set({ "n", "v", "i" }, "<leader>l", ":set list!<CR>")

vim.keymap.set("n", "<C-S-Left>", ":vertical resize +5<CR>", { remap = true, silent = true }) --
vim.keymap.set("n", "<C-S-Right>", ":vertical resize -5<CR>", { remap = true, silent = true })
vim.keymap.set("n", "<leader>w=", "<C-W>=", { remap = true, silent = true })

vim.keymap.set("n", "<leader>wh", "<C-W>h", { remap = true, silent = true })
vim.keymap.set("n", "<leader>wj", "<C-W>j", { remap = true, silent = true })
vim.keymap.set("n", "<leader>wk", "<C-W>k", { remap = true, silent = true })
vim.keymap.set("n", "<leader>wl", "<C-W>l", { remap = true, silent = true })

vim.keymap.set("n", "<leader>wq", "<C-W><C-Q>", { remap = true, silent = true })
vim.keymap.set("n", "<leader>wo", "<C-W><C-O>", { remap = true, silent = true })

-- clean trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.py" },
	command = ":%s/s+$//e",
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.c", "*.h" },
	command = "silent! !ctags . &",
})

vim.s.hasfolder = 1
vim.g.foldertoopen = "."
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 1
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 20
vim.g.netrw_altv = 1

if not has("gui_running") then
	vim.opt.t_Co = 256
	vim.opt.background = "dark"
	vim.opt.termguicolors = true
	vim.opt.colorscheme = "default"
end

if has("gui_running") then
	vim.opt.guioptions = vim.opt.guioptions - "m"
	vim.opt.guioptions = vim.opt.guioptions - "T"
	vim.opt.guioptions = vim.opt.guioptions - "r"
	vim.opt.guioptions = vim.opt.guioptions - "L"

	if has("gui_win32") then
		vim.opt.guifont = "Fira_Code:h10:cANSI"
	else
		vim.opt.guifont = "Consolas 10"
	end
end

vim.api.nvim_create_user_command("GitPlugin", function(input)
	local repo = input.fargs
	local url = "https://github.com/%s/%s.git"
	local plugin_dir = vim.fn.stdpath("config") .. "/pack/plugin/start/%s"

	if repo[1] == nil or repo[2] == nil then
		local msg = "Must provide user name and repository"
		vim.notify(msg, vim.log.levels.WARN)
		return
	end

	local full_url = url:format(repo[1], repo[2])
	local command = { "git", "clone", full_url, plugin_dir:format(repo[2]) }

	local on_done = function()
		vim.cmd("packloadall! | helptags ALL")
		vim.notify("Done.")
	end

	vim.notify("Cloning repository...")
	vim.fn.jobstart(command, { on_exit = on_done })
end, { nargs = "+" })

GitPlugin tpope vim-surround.git
GitPlugin sheerun vim-polyglot
GitPlugin vim-syntastic syntastic
GitPlugin itchyny lightline.vim

-- Show EOL type and last modified timestamp, right after the filename
vim.opt.statusline = '%<%F%h%m%r [%{&ff}] (%{strftime("%Y-%m-%d %H:%M:%S",getftime(expand("%:p")))})%=%l,%c%V %P'

-- Syntastic minimal setup
vim.opt.noshowmode = true
vim.opt.statusline = "%#warningmsg# %{SyntasticStatuslineFlag()} %*"

vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 1
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0


