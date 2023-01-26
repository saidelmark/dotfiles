" {{{1 Plugins
lua <<EOF
require 'saidelman/plugins'
EOF

" {{{1 Folds
lua << EOF
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 9 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 9
vim.o.foldenable = true
local ufo = require('ufo')
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
vim.keymap.set('n', 'zm', ufo.closeFoldsWith)
EOF
augroup vim_folding
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
augroup git_folding
  autocmd!
  autocmd FileType git,gitcommit,fugitive setlocal foldlevel=99
augroup END
augroup TSfolding
  autocmd!
  autocmd FileType c,go,lua,nix,terraform,yaml
    \ setlocal foldmethod=expr |
    \ setlocal foldexpr=nvim_treesitter#foldexpr()
augroup END
" }}}

  " How often vim refreshes the buffer
  set updatetime=100

  set hidden
  " Ignore case when sort files in netrw
  let g:netrw_sort_options="i"
  " This will show lines numbers.
  " 'relativenumber' option shows offset from current line to every other one
  set number relativenumber
  set cursorline

  set scrolloff=5

  " Enable mouse scrolling (not only, but it's the main feature for me).
  set mouse=a
  " This option changes default `tab` behavior
  " tabs are replaces with spaces and are 2 symbols wide
  set expandtab
  set shiftwidth=2
  set tabstop=4

  set ignorecase smartcase

  " visible tabs and trailing spaces
  set list

  " This option shows the command on the bottom of the screen
  set showcmd

  " Not sure if I want to disable backups
  " Don't save backup files
  set nobackup
  set nowritebackup

  " Better display for messages
  set cmdheight=2

  " Provides completion for all file-related tasks
  set path+=**

  " This makes open new splits below and to the right
  set splitbelow splitright

  " autosources vimrc after every :w
  augroup myvimrc
    autocmd!
    autocmd BufWritePost init.vim
        \ nested source $MYVIMRC |
        \ set ft=vim
  augroup END

" {{{ Key bindings
nnoremap <Space> <Nop>
let mapleader = " "
let maplocalleader = "\\"

" I'm too lazy to hit shift all the time
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :

" Old habit from Far Manager editor
nnoremap <silent> <F2> :w<CR>
inoremap <silent> <F2> <ESC><C-G>:w<CR>a

nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>es :split $MYVIMRC<cr>

" Open git status in a narrow buffer in the right half of the window
nnoremap <silent> <leader>G :vert G \| vert resize 70<cr>
" }}}

" ===========
" Auto commands
" ===========

  augroup prose
    autocmd!
    autocmd FileType markdown,gitcommit,plaintext,text
      \ setlocal spell linebreak
  augroup END

  augroup sublime_syntax
    autocmd!
    autocmd BufRead,BufNewFile *.sublime-settings set filetype=json
  augroup END

  augroup go_syntax
    autocmd!
    autocmd FileType go set foldmethod=syntax
  augroup END

  augroup refresh_buffers
    autocmd!
    autocmd FocusGained,BufEnter * :checktime
  augroup END

" {{{ Keyboard layouts
" This section doesn't really work as described, should tweak it

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchNLayout = 'us'

let g:XkbSwitchKeymapNames = {'ru' : 'russian-jcukenwin'}
let g:XkbSwitchAssistNKeymap = 1    " for commands r and f

set spelllang=en_us,ru_yo " }}}




" }}}

let g:rainbow_active = 1
