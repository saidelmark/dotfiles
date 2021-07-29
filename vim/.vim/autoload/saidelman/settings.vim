" Shamelessly stolen from wincent's dotfiles:
" https://github.com/wincent/wincent/blob/796ee1c02ad257fd565569ab6082b7685a52b83f/aspects/vim/files/.vim/autoload/wincent/settings.vim
scriptencoding utf-8

let s:small_l='ℓ'

" Override default `foldtext()`, which produces something like:
"
"   +---  2 lines: source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim--------------------------------
"
" Instead returning:
"
"     source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim [2ℓ]                                        
"
" Note that there are spaces in the beginning of the line and trailing spaces.

function! saidelman#settings#foldtext() abort
  let l:lines=' [' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:first=substitute(l:first, '^.* *{{{. *', '', '')
  let l:dashes=substitute(v:folddashes, '-', '  ', 'g')
  return l:dashes . l:first . l:lines
endfunction
