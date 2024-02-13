local kmap=vim.keymap.set
local o=vim.opt
local g=vim.g

o.number=true
o.backspace='2'
o.guicursor='i:block'
o.splitright=true
o.splitbelow=true
o.softtabstop=4
o.shiftwidth=4
o.smartindent=true
o.linebreak=true

g.t_Co=256
g.mapleader = " "
kmap("n", "<leader>pv", vim.cmd.Ex)
kmap('n','<C-w>N',':vnew<CR>')
kmap('n','<C-h>','<C-w>h')
kmap('n','<C-j>','<C-w>j')
kmap('n','<C-k>','<C-w>k')
kmap('n','<C-l>','<C-w>l')

kmap('n','bn',':bnext<CR>')
kmap('n','bN',':bprevious<CR>')

kmap('n','<F6>',':setlocal spell! spelllang=en_us<CR>')
kmap('n','<F5>', ":so ~/.config/nvim/init.lua<CR>")
kmap('n','<Leader>r', ":so ~/.config/nvim/init.lua<CR>")
kmap('n','<Leader>h', ':nohlsearch<CR>')
kmap('t','<ESC>','<C-w>:q!<CR>')
kmap('i','jj','<esc>')
kmap('n','bD', ':set background=dark<cr>')
kmap('n','bL', ':set background=light<cr>')
kmap('n','<leader>D', ':Gdiff<cr>')
kmap('n','<leader>B', ':G blame<cr>')
kmap('n','<leader>gf', ':edit %:h/<cfile><CR>')

-- remember last place
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds({ group = lastplace })
vim.api.nvim_create_autocmd("BufReadPost", { group = lastplace, pattern = { "*" }, desc = "remember last cursor place", callback = function() local mark = vim.api.nvim_buf_get_mark(0, '"') local lcount = vim.api.nvim_buf_line_count(0) if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end end, })

-- plugins with vim-plug
vim.cmd [[
" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
  Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'tpope/vim-fugitive'
Plug 'exafunction/codeium.vim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'jvirtanen/vim-hcl', { 'for' : 'hcl' }
call plug#end()
]]

--o.termguicolors = true
require("gruvbox").setup({
    terminal_colors = true,
    transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")

g.codeium_filetypes = {
   markdown = false,
   text = false
}
kmap("n",'<leader>ai',':CodeiumToggle<cr>')

kmap("n","<leader>gs",vim.cmd.Git)

local lspconfig = require('lspconfig')

require('lualine').setup {
  options = { theme  = 'iceberg' },
}

local builtin = require('telescope.builtin')
kmap('n','<leader>pf', builtin.find_files, {})
kmap('n','<leader>f', builtin.find_files, {})
kmap('n','<C-p>', builtin.git_files, {})
kmap('n','<leader>ps', function()
	builtin.grep_string( { search=vim.fn.input("grep > ") })
end)

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "vim", "vimdoc", "query", "bash", "rust", "c", "go", "ruby", "markdown", "python", "yaml" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
