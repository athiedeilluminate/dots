local set=vim.opt
local vg=vim.g
local kmap=vim.keymap.set

set.number=true
set.relativenumber=true
set.backspace='2'
set.background='dark'
--set.cc='80'
set.ignorecase=true
set.smartcase=true
set.incsearch=true
set.hlsearch=true
-- block cursor
set.guicursor='i:block'

set.smartindent=true
set.tabstop=4
set.shiftwidth=4
--set.expandtab=true
set.linebreak=true
vg.filetype='indent on'

set.statusline="%#PmenuSel#%#LineNr# %f%m %=%#CursorColumn# %y %{&fileencoding?&fileencoding:&encoding}[%{&fileformat}] %p%% %l:%c"

set.mouse='a'
--set.wildmode='longest,list,full'
set.wildmenu=true

kmap('n','<C-w>N',':vnew<CR>')
kmap('n','<C-h>','<C-w>h')
kmap('n','<C-j>','<C-w>j')
kmap('n','<C-k>','<C-w>k')
kmap('n','<C-l>','<C-w>l')

vg.mapleader=','
kmap('n','bn',':bNext<CR>')
kmap('n','<F6>',':setlocal spell! spelllang=en_us<CR>')
kmap('n','<F5>', ":so ~/.config/nvim/init.lua<CR>")
kmap('n','<Leader>r', ":so ~/.config/nvim/init.lua<CR>")
kmap('n','<leader>f', ':NERDTreeToggle<cr>')
kmap('n','<Leader>h', ':nohlsearch<CR>')
kmap('t','<ESC>','<C-w>:q!<CR>')
kmap('i','jj','<esc>')
kmap('n','<F4>', ':! %<cr>')
kmap('n','<F2>', ':NERDTreeToggle<cr>')
kmap('n','bD', ':set background=dark<cr>')
kmap('n','bL', ':set background=light<cr>')
kmap('n','<leader>D', ':Gdiff<cr>')
kmap('n','<leader>B', ':G blame<cr>')
kmap('n','<leader>gf', ':edit %:h/<cfile><CR>')

-- buffer bar plugin - don't use icons
require'barbar'.setup { icons = { filetype = { enabled = false } } }
kmap('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)

-- codeium AI enabled/disabled
vg.codeium_enabled = false

