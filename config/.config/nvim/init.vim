set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

source ~/.vimrc

lua require('dependencies')
lua require('keymap')
lua require('theme').configure()
