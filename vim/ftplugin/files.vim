"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Strip whitespaces and tabs on buffer write
autocmd BufWritePre <buffer> :call StripWsTabs()

" Open templates when editing a new file.
au bufNewFile *.c 0r        ~/.config/nvim/templates/template.c
au bufNewFile *.cpp 0r      ~/.config/nvim/templates/template.cpp
au bufNewFile *.h 0r        ~/.config/nvim/templates/template.h
au bufNewFile *.v 0r        ~/.config/nvim/templates/template.v
au bufNewFile *.sv 0r       ~/.config/nvim/templates/template.sv
au bufNewFile *.html 0r     ~/.config/nvim/templates/template.html
au bufNewFile *.py 0r       ~/.config/nvim/templates/template.py
au bufNewFile *.sh 0r       ~/.config/nvim/templates/template.sh
au bufNewFile *.S 0r        ~/.config/nvim/templates/template.S

" Colorize ANSI escape codes by default with AnsiEsc plugin for txt and log extension
autocmd BufRead,BufNewFile *.{log,txt} AnsiEsc

" Specify JSON syntax checking for Javascript
au BufRead,BufNewFile *.json set filetype=javascript

" C linker
au BufRead,BufNewFile *.ld set filetype=ld


" Specify Markdown syntax checking for these extensions
au BufRead,BufNewFile *.mkd, *.md, *.txt set filetype=markdown.pandoc

" Insert tabs, not spaces for Makefile
autocmd FileType make setlocal noexpandtab
