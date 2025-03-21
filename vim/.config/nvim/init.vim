" {{{1 Plugins
lua <<EOF
require('saidelman.plugins')
require('saidelman.keymaps')
EOF

" {{{1 Folds
augroup sxhkdrc
  autocmd!
  autocmd BufEnter sxhkdrc,*.sxhkdrc set ft=sxhkdrc
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

" ===========
" Auto commands
" ===========

  augroup sublime_syntax
    autocmd!
    autocmd BufRead,BufNewFile *.sublime-settings set filetype=json
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
