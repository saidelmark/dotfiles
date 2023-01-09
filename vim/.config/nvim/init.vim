" {{{1 Plugins
lua <<EOF
-- bootstrapping
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- general quality of life
  use 'tpope/vim-sensible'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-abolish'
  use 'mbbill/undotree'
  use 'michaeljsmith/vim-indent-object'
  use 'jeetsukumaran/vim-indentwise'
  use "tversteeg/registers.nvim"
  use {
    "kevinhwang91/nvim-ufo",
    requires = { "kevinhwang91/promise-async" }
  }
  use {
    "ibhagwan/fzf-lua",
    requires = { "nvim-tree/nvim-web-devicons" }
  }
  use "dhruvasagar/vim-table-mode"
  use "tmux-plugins/vim-tmux-focus-events"
  use "chentoast/marks.nvim"
  use "lyokha/vim-xkbswitch"

  use "npxbr/glow.nvim"

  -- visual
  use {
    "vim-airline/vim-airline",
    requires = {"vim-airline/vim-airline-themes"}
  }
  use 'NvChad/nvim-colorizer.lua'
  use "luochen1990/rainbow"
  use "NLKNguyen/papercolor-theme"

  -- git stuff
  use {
    'tpope/vim-fugitive',
    requires = {
      'tpope/vim-rhubarb',
      'shumphrey/fugitive-gitlab.vim',
    },
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns/gitsigns') end
  }
  use 'rhysd/git-messenger.vim'

  -- syntax for all languages I use
  use 'kovetskiy/sxhkd-vim'
  use 'neovimhaskell/haskell-vim'
  use 'chr4/nginx.vim'
  use 'towolf/vim-helm'
  use 'hashivim/vim-terraform'
  use 'tmux-plugins/vim-tmux'
  use 'LnL7/vim-nix'
  use 'timmyjose-projects/lox.vim'
  use 'cespare/vim-toml'

  -- completion
  use {
    'hrsh7th/nvim-cmp',
    config = function() require('cmp/cmp') end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-cmdline'
    }
  }

  -- lsp and treesitter related
  use {
    'tami5/lspsaga.nvim',
    requires = { 'neovim/nvim-lspconfig' },
    config = function() require('lsp/lspconfig') end,
  }
  use 'simrat39/rust-tools.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run=':TSUpdateSync',
    config = function() require('treesitter/config') end,
  }

  -- dev tools
  use 'tpope/vim-commentary'
  if packer_bootstrap then
    require('packer').sync()
  end
end)
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
  \       }
  \     }
  \   }
  \ }
  colorscheme PaperColor
  lua require 'colorizer'.setup({user_default_options = {mode = "virtualtext",}})
endif

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
" {{{1 Git
augroup git
  autocmd!
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>p 0ciwpick<esc>0
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>r 0ciwreword<esc>0
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>d 0ciwdrop<esc>0
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>e 0ciwedit<esc>0
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>s 0ciwsquash<esc>0
  autocmd FileType gitrebase nnoremap <buffer> <silent> <localleader>f 0ciwfixup<esc>0
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
lua << EOF
  local registers = require('registers')
  registers.setup{
    window = {
      border = "rounded",
    },
  }
EOF
" {{{1 Fzf
lua <<EOF
require("fzf-lua").setup ({
  -- The following are keymamp active when fzf window is active
  keymap = {
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<F1>"]        = "toggle-help",
      ["<F2>"]        = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]        = "toggle-preview-wrap",
      ["<F4>"]        = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]        = "toggle-preview-ccw",
      ["<F6>"]        = "toggle-preview-cw",
      ["<M-j>"]    = "preview-page-down",
      ["<M-k>"]    = "preview-page-up",
    },
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-z"]      = "abort",
      ["ctrl-u"]      = "unix-line-discard",
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-b"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
      ["alt-a"]       = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]          = "toggle-preview-wrap",
      ["f4"]          = "toggle-preview",
      -- scrolling the preview
      ["shift-down"]  = "preview-page-down",
      ["shift-up"]    = "preview-page-up",
      ["alt-j"] = "preview-down",
      ["alt-k"] = "preview-up",
    },
  },
})
EOF
nnoremap <silent> <C-M-P> :FzfLua commands<CR>
nnoremap <silent> <C-P> :FzfLua files<CR>

" {{{1 Marks
lua <<EOF
require'marks'.setup {
  mappings = {
    next = "]m",
    prev = "[m"
  }
}
EOF
"}}}

let g:rainbow_active = 1
