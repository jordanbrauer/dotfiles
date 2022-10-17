set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

source ~/.vimrc

lua require('plugins')
lua require('keymap')
lua require('theme')
