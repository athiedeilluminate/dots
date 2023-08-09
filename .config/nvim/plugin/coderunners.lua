-- loop through list of languages and their 'runners' and create autocommands
-- that run the code through the preferred runner
local augroup=vim.api.nvim_create_augroup('run_cmds',{clear=true})
local acmd=vim.api.nvim_create_autocmd
langs={
    ['c']='c',
    ['go']='g run',
    ['hare']='hr run',
    ['lua']='luajit',
    ['python']='python3',
    ['ruby']='rb',
    ['rust']='rs',
    ['html']='firefox'
}
-- two maps per runner, one for insert and one for normal mode
for i,v in pairs(langs) do
    local ncmd="map <buffer> <F4> :w<CR>:exec '!"..v.."' shellescape(@%,1)<CR>"
    local icmd="imap <buffer> <F4> <ESC>:w<CR>:exec '!"..v.."' shellescape(@%,1)<CR>"
    acmd('FileType', {pattern=i, group='run_cmds', command=ncmd})
    acmd('FileType', {pattern=i, group='run_cmds', command=icmd})
    local ncmd2="map <buffer> <Leader>R :w<CR>:exec '!"..v.."' shellescape(@%,1)<CR>"
    local icmd2="imap <buffer> <Leader>R <ESC>:w<CR>:exec '!"..v.."' shellescape(@%,1)<CR>"
    acmd('FileType', {pattern=i, group='run_cmds', command=ncmd2})
    acmd('FileType', {pattern=i, group='run_cmds', command=icmd2})
end

