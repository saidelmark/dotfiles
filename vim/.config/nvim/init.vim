" ============
" PLUGINS CONFIGURATION
" ============

" list of plugins
call plug#begin()
  " Sane defaults, just to clean this file up a bit
  Plug 'tpope/vim-sensible'
  " Git wrapper and helper
  Plug 'tpope/vim-fugitive'
  " Git status markers
  Plug 'airblade/vim-gitgutter'
  " Try out an enhanced file manager
  Plug 'tpope/vim-vinegar'
  " adds commands for surrounding text objects
  Plug 'tpope/vim-surround'
  " adds pretty status line
  Plug 'vim-airline/vim-airline'
  " adds new text object: arguement
  Plug 'vim-scripts/argtextobj.vim'
  " Adds new text object: indentation
  Plug 'michaeljsmith/vim-indent-object'
  " Have more changes repeateable
  Plug 'tpope/vim-repeat'
  " Linting engine
  Plug 'dense-analysis/ale'
  " LSP support (check for conflicts with ALE
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Personal wiki
  Plug 'vimwiki/vimwiki'
  " Toggles comment on any given text object
  Plug 'tpope/vim-commentary'
  " simple x hot key daemon syntax
  Plug 'kovetskiy/sxhkd-vim'
  " Haskell syntax highlighting
  Plug 'neovimhaskell/haskell-vim'
  " Shortcuts for some commands, usually going in pairs (like next/prev)
  Plug 'tpope/vim-unimpaired'
  " Automatically switch layout in insert mode
  Plug 'lyokha/vim-xkbswitch'
  " I like sublime's default colors
  Plug 'ErichDonGubler/vim-sublime-monokai'
call plug#end()

" ============
" BASE CONFIGURATION
" ============

  " Use TrueColor option
  " TODO: enable it only in terminals that support it, otherwise use t_Co=256
  if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
    colorscheme sublimemonokai
    let g:sublimemonokai_term_italic = 1
    set t_ut=
  endif

  " How often vim refreshes the buffer
  set updatetime=100

  " This will show lines numbers.
  " 'relativenumber' option shows offset from current line to every other one
  set number relativenumber
  " Colors of line numbers
  highlight LineNrAbove ctermfg=grey
  highlight LineNrBelow ctermfg=grey
  highlight LineNr ctermfg=brown
  set cursorline

  set scrolloff=5

  " Enable mouse scrolling (not only, but it's the main feature for me).
  " ttymouse is alacritty-specific, see https://github.com/alacritty/alacritty/issues/803 for details
  if !has('nvim')
    set ttymouse=sgr
  endif
  set mouse=a
  " This option changes default `tab` behavior
  " tabs are replaces with spaces and are 2 symbols wide
  set expandtab
  set shiftwidth=2
  set tabstop=8

  " visible tabs and trailing spaces
  " set list

  " " Enable folding
  " set foldmethod=indent
  " set foldlevel=99

  " This option shows the command on the bottom of the screen
  set showcmd

  " Not sure if I want to disable backups
  " Don't save backup files
  set nobackup
  set nowritebackup

  " Better display for messages
  set cmdheight=2

  " Provides tab-completion for all file-related tasks
  set path+=**

  " This makes open new splits below and to the right
  set splitbelow splitright

  " autosources vimrc after every :w
  augroup myvimrc
    autocmd!
    autocmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc
      \ so $MYVIMRC |
      \ if has('gui_running') |
        \ so $MYGVIMRC |
      \ endif
  augroup END

" ===========
" C specific
" ===========

  augroup filetype_c
    autocmd!
    " For C I'm trying to follow Linux Kernel's style
    autocmd filetype c
      \ setlocal noexpandtab |
      \ setlocal tabstop=8 |
      \ setlocal shiftwidth=8
  augroup END

" ===========
" Key bindings
" ===========

  let mapleader = "\\"
  let maplocalleader = "="

  " I'm too lazy to hit shift all the time
  nnoremap : ;
  nnoremap ; :
  vnoremap : ;
  vnoremap ; :

  nnoremap <leader>ev :vsplit $MYVIMRC<cr>

  noremap <up> <nop>
  noremap <down> <nop>
  noremap <left> <nop>
  noremap <right> <nop>

  noremap <pageup> <nop>
  noremap <pagedown> <nop>
  noremap <end> <nop>
  noremap <home> <nop>

  inoremap <up> <nop>
  inoremap <down> <nop>
  inoremap <left> <nop>
  inoremap <right> <nop>

  inoremap <pageup> <nop>
  inoremap <pagedown> <nop>
  inoremap <end> <nop>
  inoremap <home> <nop>

" ===========
" Auto commands
" ===========

  " Some buffers have to be checked unconditionally
  augroup spelling
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd FileType gitcommit setlocal spell
  augroup END

  augroup markdown_defaults
    autocmd!
    " In markdown trailing spaces may be useful
    autocmd FileType markdown setlocal nolist
  augroup END

  augroup python_defaults
    autocmd!
    au BufRead,BufNewFile *.py
      \ setlocal tabstop=4 |
      \ setlocal softtabstop=4 |
      \ setlocal shiftwidth=4 |
      \ setlocal textwidth=79 |
      \ setlocal expandtab |
      \ setlocal autoindent |
      \ setlocal fileformat=unix
  augroup END

" ===========
" Language
" ===========

  " This section doesn't really work as described, should tweak it

  set keymap=russian-jcukenwin
  set iminsert=0
  set imsearch=0
  " TODO: this line doesn't work, find solution
  " highlight lCursor guifg=NONE guibg=Cyan

  let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'
  let g:XkbSwitchEnabled = 1
  let g:XkbSwitchIMappings = ['ru']
  let g:XkbSwitchNLayout = 'us'

  let g:XkbSwitchKeymapNames = {'ru' : 'russian-jcukenwin'}
  let g:XkbSwitchAssistNKeymap = 1    " for commands r and f
  let g:XkbSwitchAssistSKeymap = 1    " for search lines

  set spelllang=en_us,ru_yo

  let g:vimwiki_list = [{'path': '~/Documents/vimwiki/'}]

" ============
" AIRLINE CONFIGURATION
" ============

  " Only show tabline if there are tabs
  let g:airline#extensions#tabline#tab_min_count = 2

  " This enables airline style for tabline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_tabs = 1
  " Don't ever show buffer list as if they are tabs
  let g:airline#extensions#tabline#show_buffers = 0
  " enables better fonts, nicer symbols, etc
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail'

  " Don't show keymap segment, xkb-switch is enough
  let g:airline#extensions#keymap#enabled = 0

  let g:airline_skip_empty_sections = 1
  let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
  " let g:airline#parts#ffenc#skip_expected_string='[unix]'

" ============
" ALE
" ============

  let g:ale_fixers = {
  \    'haskell': [
  \     'brittany',
  \     'hlint'
  \   ],
  \ }

