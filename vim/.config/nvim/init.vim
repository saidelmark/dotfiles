" {{{1 Plugins
call plug#begin()
  " Sane defaults, just to clean this file up a bit
  Plug 'tpope/vim-sensible'
  " Shortcuts for some commands, usually going in pairs (like next/prev)
  Plug 'tpope/vim-unimpaired'
  " Git wrapper and helper
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  " Git status markers
  Plug 'airblade/vim-gitgutter'
  " Popup with commit message for current line
  Plug 'rhysd/git-messenger.vim'
  " Try out an enhanced file manager
  Plug 'tpope/vim-vinegar'
  " adds commands for surrounding text objects
  Plug 'tpope/vim-surround'
  " Have more changes repeateable
  Plug 'tpope/vim-repeat'
  " Change snace_case to MixedCase in one simple command
  Plug 'tpope/vim-abolish'
  " Interactive visual representation of vim's undo tree
  Plug 'mbbill/undotree'
  " adds pretty status line
  Plug 'vim-airline/vim-airline'
  " Adds new text object: indentation
  Plug 'michaeljsmith/vim-indent-object'
  " Add intentation-based movements
  Plug 'jeetsukumaran/vim-indentwise'
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
  " Automatically switch layout in insert mode
  Plug 'lyokha/vim-xkbswitch'
  " I like sublime's default colors
  Plug 'ErichDonGubler/vim-sublime-monokai'
  " Highly experimental, Borland-like menus and windows
  " Plug 'skywind3000/vim-quickui'
  " Try more sane syntax for dockerfiles
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'chr4/nginx.vim'
  Plug 'towolf/vim-helm'
  Plug 'hashivim/vim-terraform'
  Plug 'cespare/vim-toml'

  " Fuzzy finding files, buffers, some other nice things
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " Tmux-specific plugins
  " Allows syntax for tmux config and live config application
  Plug 'tmux-plugins/vim-tmux'
  " Fixes FocusGained and FocusLost autocommand events while inside tmux
  Plug 'tmux-plugins/vim-tmux-focus-events'

  " Nix language filetype
  Plug 'LnL7/vim-nix'
  " Popup window with the content of all registers
  Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
call plug#end()

" {{{1 Colors
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

" {{{1 Folds
if has('folding')
  if has('windows')
    set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
    set fillchars+=fold:\             " Don't want distracting symbols, so just space
  endif
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=0                " start folded
  set foldtext=saidelman#settings#foldtext()
  augroup vim_folding
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
  augroup END
  augroup git_folding
    autocmd!
    autocmd FileType git,gitcommit,fugitive setlocal foldlevel=99
  augroup END
endif " }}}

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

  " Provides tab-completion for all file-related tasks
  set path+=**

  " This makes open new splits below and to the right
  set splitbelow splitright

  " autosources vimrc after every :w
  augroup myvimrc
    autocmd!
    autocmd BufWritePost init.vim,.vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc
      \ so $MYVIMRC |
      \ if has('gui_running') |
        \ so $MYGVIMRC |
      \ endif |
      \ set ft=vim
  augroup END

" {{{ Key bindings
nnoremap <Space> <Nop>
let mapleader = " "
" "=" is used for formatting. I should reconsider local leader key.
" let maplocalleader = "="

" I'm too lazy to hit shift all the time
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :

" Old habit from Far Manager editor
nnoremap <F2> :w<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Open git status in a nerrow buffer in the right half of the window
nnoremap <silent> <leader>G :vert G \| vert resize 70<cr>
" }}}

" ===========
" Auto commands
" ===========

  " Some buffers have to be spell checked unconditionally
  augroup spelling
    autocmd!
    autocmd FileType markdown,gitcommit,plaintext,text setlocal spell
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
let g:XkbSwitchAssistSKeymap = 1    " for search lines

set spelllang=en_us,ru_yo " }}}

  let g:vimwiki_list = [{'path': '~/Documents/vimwiki/'}]

" {{{ Airline
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
" Git information takes too much space and gives too little
let g:airline_section_b = ""
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline#parts#ffenc#skip_expected_string='[unix]' }}}


" {{{1 LSP, formatting, etc.
" ctrl+space trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
let g:ale_disable_lsp = 1

let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\    'terraform': ['terraform'],
\    'haskell': ['britanny', 'hlint', 'hindent', 'stylish-haskell'],
\ }
" {{{1 Git messenger
" {{{ Colors
hi link gitmessengerPopupNormal Folded
hi link gitmessengerHeader Statement
hi link gitmessengerHash Special
hi link gitmessengerHistory Title
" }}}
let g:git_messenger_max_popup_height = 20
let g:git_messenger_max_popup_width = 80
let g:git_messenger_floating_win_opts = { 'border': 'rounded' }
let g:git_messenger_popup_content_margins = v:false
let g:git_messenger_always_into_popup = v:true

" {{{1 UndoTree
nnoremap <silent> <F7> :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2 " Tree on the left, diff below
let g:undotree_HighlightChangedText = 0
let g:undotree_SetFocusWhenToggle = 1

" {{{1 Registers
hi link RegistersWindow Comment
let g:registers_window_border = "rounded"
