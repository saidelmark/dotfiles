" {{{1 Plugins
lua <<EOF
require "paq" {
  "savq/paq-nvim";
  -- Sane defaults, just to clean this file up a bit
  "tpope/vim-sensible";
  -- Shortcuts for some commands, usually going in pairs (like next/prev)
  "tpope/vim-unimpaired";
  -- Git wrapper and helper
  "tpope/vim-fugitive";
  "tpope/vim-rhubarb";
  "shumphrey/fugitive-gitlab.vim";
  -- Git status markers
  "airblade/vim-gitgutter";
  -- Popup with commit message for current line
  "rhysd/git-messenger.vim";
  -- Try out an enhanced file manager
  "tpope/vim-vinegar";
  -- adds commands for surrounding text objects
  "tpope/vim-surround";
  -- Have more changes repeateable
  "tpope/vim-repeat";
  -- Change snace_case to MixedCase in one simple command
  "tpope/vim-abolish";
  -- Interactive visual representation of vim's undo tree
  "mbbill/undotree";
  -- adds pretty status line
  "vim-airline/vim-airline";
  "vim-airline/vim-airline-themes";
  -- Adds new text object: indentation
  "michaeljsmith/vim-indent-object";
  -- Add intentation-based movements
  "jeetsukumaran/vim-indentwise";
  -- Create tables easily
  "dhruvasagar/vim-table-mode";
  -- Linting engine
  "dense-analysis/ale";
  -- Personal wiki
  "vimwiki/vimwiki";
  -- Toggles comment on any given text object
  "tpope/vim-commentary";
  -- simple x hot key daemon syntax
  "kovetskiy/sxhkd-vim";
  -- Haskell syntax highlighting
  "neovimhaskell/haskell-vim";
  -- Automatically switch layout in insert mode
  "lyokha/vim-xkbswitch";
  -- I like sublime's default colors
  "ErichDonGubler/vim-sublime-monokai";
  { "npxbr/glow.nvim", branch="main" };
  "chr4/nginx.vim";
  "towolf/vim-helm";
  "hashivim/vim-terraform";
  { "cespare/vim-toml", branch="main" };

  -- Fuzzy finding files, buffers, some other nice things
  "junegunn/fzf";
  "junegunn/fzf.vim";

  -- Tmux-specific plugins
  -- Allows syntax for tmux config and live config application
  "tmux-plugins/vim-tmux";
  -- Fixes FocusGained and FocusLost autocommand events while inside tmux
  "tmux-plugins/vim-tmux-focus-events";

  -- Nix language filetype
  "LnL7/vim-nix";
  -- Popup window with the content of all registers
  { "tversteeg/registers.nvim", branch="main" };
  "neovim/nvim-lspconfig";
  {"tami5/lspsaga.nvim", branch="main"};
  { "nvim-treesitter/nvim-treesitter", run=":TSUpdate" };
  "luochen1990/rainbow";
  "NLKNguyen/papercolor-theme";
  "simrat39/rust-tools.nvim";
  "hrsh7th/nvim-cmp";
  "hrsh7th/cmp-nvim-lsp";
  "hrsh7th/cmp-buffer";
  "hrsh7th/cmp-omni";
  "hrsh7th/cmp-path";
  "hrsh7th/cmp-vsnip";
  "hrsh7th/vim-vsnip";
  "hrsh7th/cmp-nvim-lsp-signature-help";
}
EOF
" {{{1 Colors
augroup highlighting
  autocmd!
  autocmd ColorScheme * hi! ErrorMsg gui=italic
  autocmd ColorScheme * hi! link NormalFloat Normal
  autocmd ColorScheme * hi! link FloatBorder Normal
  autocmd ColorScheme * hi! Visual ctermfg=NONE guifg=NONE
  autocmd ColorScheme * hi! link SignColumn LineNr
  autocmd ColorScheme * hi! SignColumn guibg=NONE ctermbg=NONE
  autocmd ColorScheme PaperColor hi! Visual guibg=black
  autocmd ColorScheme PaperColor hi! CursorLine guibg=NONE gui=underline
augroup END
" Use TrueColor option
" TODO: enable it only in terminals that support it, otherwise use t_Co=256
if exists('+termguicolors')
  set termguicolors
  let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1,
  \       'allow_bold': 1,
  \       'allow_italics': 1,
  \       'override': {
  \         'folded_bg': [ '#272822', '' ],
  \         'folded_fg': [ '#dfdfdf', '' ]
  \       }
  \     }
  \   }
  \ }
  colorscheme PaperColor
endif

" {{{1 Folds
set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
set fillchars+=fold:\             " Don't want distracting symbols, so just space
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
augroup TSfolding
  autocmd!
  autocmd FileType c,go,lua,nix,rust,terraform,yaml
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

  " Provides tab-completion for all file-related tasks
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

  augroup glow
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <silent> <leader>p <Cmd>Glow<CR>
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
let g:XkbSwitchAssistSKeymap = 1    " for search lines

set spelllang=en_us,ru_yo " }}}

  let g:vimwiki_list = [{'path': '~/Documents/vimwiki/'}]

" {{{ Airline
let g:airline_theme = 'molokai'
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
let g:airline_detect_spell = 0
let g:airline_detect_spelllang = 0
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline#parts#ffenc#skip_expected_string='[unix]' }}}


" {{{1 LSP, formatting, etc.
lua << EOF
require('lsp/lspconfig')
require('cmp/cmp')
require('treesitter/config')
EOF
let g:ale_disable_lsp = 1

let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\    'terraform': ['terraform'],
\    'haskell': ['britanny', 'hlint', 'hindent', 'stylish-haskell'],
\ }
" {{{1 Git
augroup git
  autocmd!
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>p 0ciwpick<esc>
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>r 0ciwreword<esc>
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>d 0ciwdrop<esc>
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>e 0ciwedit<esc>
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>s 0ciwsquash<esc>
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>f 0ciwfixup<esc>
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>x oexec <c-g>u
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>X Oexec <c-g>u
augroup END
" {{{2 Git messenger
" {{{ Colors
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
nnoremap <silent> <F12> :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2 " Tree on the left, diff below
let g:undotree_HighlightChangedText = 0
let g:undotree_SetFocusWhenToggle = 1

" {{{1 Registers
let g:registers_window_border = "rounded"
" }}}
" {{{1 Fzf
nnoremap <silent> <F7> :Commands<CR>

if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p70%,50%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.5 } }
endif
"}}}

let g:rainbow_active = 1
