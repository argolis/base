""
"" /root/.vimrc
""


set ls=2 bs=2 
set ruler wildmenu 
set ml mls=1 
set ai si
set et ts=4 sw=4


autocmd BufRead,BufNewFile /var/cfengine/inputs/* set ft=cf3 ts=4 sw=4 foldlevel=99


colorscheme delek
syntax enable

" vim: ft=vim
