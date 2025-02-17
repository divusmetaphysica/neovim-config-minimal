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

vim.cmd "colorscheme zaibatsu"

local opt = vim.opt

opt.background = "dark"
opt.termguicolors = true

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.mouse = "a"

opt.laststatus = 2
opt.showcmd = true
opt.showmode = false

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
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4

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

vim.keymap.set("n", "<C-S-Left>", ":vertical resize +5<CR>", { remap = true, silent = true })
vim.keymap.set("n", "<C-S-Right>", ":vertical resize -5<CR>", { remap = true, silent = true })
vim.keymap.set("n", "<leader>w=", "<C-W>=", { remap = true, silent = true })

vim.keymap.set("n", "<leader>wh", "<C-W>h", { remap = true, silent = true })
vim.keymap.set("n", "<leader>wj", "<C-W>j", { remap = true, silent = true })
vim.keymap.set("n", "<leader>wk", "<C-W>k", { remap = true, silent = true })
vim.keymap.set("n", "<leader>wl", "<C-W>l", { remap = true, silent = true })

vim.keymap.set("n", "<leader>wq", "<C-W>q", { remap = true, silent = true })
vim.keymap.set("n", "<leader>wo", "<C-W><C-O>", { remap = true, silent = true })

-- open netrw on side pane
vim.keymap.set("n", "<leader>e", ":vsplit .<CR>:vertical resize 30<CR><C-W>r<C-W>l", { remap = true, silent = true })

-- clean trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.py" },
	command = ":%s/s+$//e",
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.c", "*.h" },
	command = "silent! !ctags . &",
})

-- Use like GitPlugin repo reponame
vim.api.nvim_create_user_command("GitPlugin", function(input)
	local repo = input.fargs
	local url = "https://github.com/%s/%s.git"
	local plugin_dir = vim.fn.stdpath("config") .. "/pack/plugins/start/%s"

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

-- Show EOL type and last modified timestamp, right after the filename
vim.opt.statusline = '%<%F%h%m%r [%{&ff}] (%{strftime("%Y-%m-%d %H:%M:%S",getftime(expand("%:p")))})%=%l,%c%V %P'

--Plugin setups
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'palenight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})

require("mini.surround").setup({
  -- Add custom surroundings to be used on top of builtin ones. For more
  -- information with examples, see `:h MiniSurround.config`.
  custom_surroundings = nil,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = 'sa', -- Add surrounding in Normal and Visual modes
    delete = 'sd', -- Delete surrounding
    find = 'sf', -- Find surrounding (to the right)
    find_left = 'sF', -- Find surrounding (to the left)
    highlight = 'sh', -- Highlight surrounding
    replace = 'sr', -- Replace surrounding
    update_n_lines = 'sn', -- Update `n_lines`

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },

  -- Number of lines within which surrounding is searched
  n_lines = 20,

  -- Whether to respect selection type:
  -- - Place surroundings on separate lines in linewise mode.
  -- - Place surroundings on each line in blockwise mode.
  respect_selection_type = false,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
  -- see `:h MiniSurround.config`.
  search_method = 'cover',

  -- Whether to disable showing non-error feedback
  -- This also affects (purely informational) helper messages shown after
  -- idle time if user input is required.
  silent = false,
})
