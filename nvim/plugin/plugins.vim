"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key setup, handled with vim-leader-mapper
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Define the sub-menu dedicated to Markdown tool
let MdMenu = {'name':  "Markdown Menu",
             \'tk':  [":MdAddTask",          "Add a new task"],
             \'stk': [":MdAddSubTask",       "Add a new sub task"],
             \'tt':  [":MdChangeToTask",     "Change list item to task"],
             \'tb':  [":MdAddTable",         "Add a table"],
             \'ac':  [":MdAddColumn",        "Add a column"],
             \'ar':  [":MdAddRow",           "Add a row"],
             \'swc': [":MdSwapColumn",       "Swap two columns"],
             \'swr': [":MdSwapRow",          "Swap two rows"],
             \'p':   [":MdPrettify",         "Prettify a table"],
             \'i':   [":MdAddImage",         "Add image"],
             \'l':   [":MdAddLink",          "Add link"],
             \'c':   [":MdAddCode",          "Add code block"],
             \'sn':  [":MdStatusNew",        "Assign to task 'New' status"],
             \'so':  [":MdStatusOngoing",    "Assign to task 'Ongoing' status"],
             \'sc':  [":MdStatusCancel",     "Assign to task 'Cancel' status"],
             \'sd':  [":MdStatusDone",       "Assign to task 'Done' status"],
             \}

" Define FZF leader key menu
let g:FZFMenu = {'name':  "FZF Menu",
             \'f': [":Files",                       "FZF file search"],
             \'b': [":Buffers",                     "FZF buffer search"],
             \'s': [":BLines",                      "FZF text search into current buffer"],
             \'S': [":Lines",                       "FZF text search across loaded buffers"],
             \'g': [":BCommits",                    "FZF git commits of the current buffer"],
             \'G': [":Commits",                     "FZF git commits of the repository"],
             \'t': [':Tags',                        'FZF tag search'],
             \'h': [':History:',                    'FZF command history search'],
             \}

" Define Main leader key menu
let g:leaderMenu = {'name':  "Main",
             \'f': [FZFMenu,                        "Open FZF menu"],
             \'m': [MdMenu,                         'Open Markdown menu'],
             \'v': [':vsplit',                      'Split buffer vertically'],
             \'h': [':split',                       'Split buffer horizontally'],
             \'H': [':hide',                        'Hide panel'],
             \'d': [':Bclose',                      'Close buffer'],
             \'l': [':ls',                          'List opened buffers'],
             \'p': [':call Prettify()',             'Prettify the buffer'],
             \'t': [':call BuildCtags()',           'Create tags'],
             \'o': [':normal gF',                   'Open file under cursor'],
             \'e': [':NERDTreeToggle',              'Open/Close NerdTree'],
             \'c': [':Commenter',                   'Toggle comment of current line or visual selection'],
             \':': [':call FloatTerm()',            'Open a floating terminal'],
             \'b': [':make',                        'Run make program (set makeprg="..." to setup)'],
             \'x': [':%!xxd',                       'Display a buffer in hexadecimal'],
             \}

" Define leader key to space and call vim-leader-mapper
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable fzf
set rtp+=~/.fzf

" ctrl-h or ctrl-v can be pressed to open a file found
" into a new panel
let g:fzf_action = {
            \ 'ctrl-h': 'split',
            \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'

function! FloatingFZF()
let width = float2nr(&columns * 0.7)
let height = float2nr(&lines * 0.5)
let opts = { 'relative': 'editor',
            \ 'row': (&lines - height) / 2,
            \ 'col': (&columns - width) / 2,
            \ 'width': width,
            \ 'height': height }

let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
endfunction

let g:fzf_layout = { 'window': 'call FloatingFZF()' }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoFormat setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <C-T> <C-]>
set tags=tags,./tags,./../tags,./*/tags


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlXA
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup VimAfter
    autocmd!
    autocmd VimEnter let g:CtrlXA_Toggles = [
    \   ['input', 'output'],
    \   ['reg', 'wire', 'logic'],
    \   ['===', '!=='],
    \   ['task', 'function'],
    \   ['posedge', 'negedge'],
    \   ['New', 'Change', 'Fix', 'Feature', 'Refactor', 'Chore', 'Doc'],
    \ ] + g:CtrlXA_Toggles
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use NERDTree because netrw suffers several problems:
" - open empty buffer, and may prevent to close vim
" - don't auto close explore once a file is selected
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '✺'

" Specify rustc and not cargo as default checker
let g:ale_linters = {
\   'verilog_systemverilog': [''],
\   'rust': ['rustc'],
\   'c': ['clang'],
\}

" Specify rustc option for linting (avoid to use nightly build)
let g:ale_rust_rustc_options=""
let g:ale_verilog_iverilog_options = "-g2012 -I./ -I../ -Isrc/ -I../src -f files.f"
let g:ale_verilog_verilator_options = "+1800-2017ext+sv +1800-2005ext+v -Wno-STMTDLY -Wno-UNUSED -Wno-UNDRIVEN"
let g:ale_c_clangtidy_options = "-I /opt/riscv/include"
