" General settings {{{
" Paths {{{
let $NVIMHOME = $HOME . '/.config/nvim/'
" }}}
" Text display and editing {{{
set backspace=indent,eol,start

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent

set textwidth=100      " Break lines at 100 characters
set colorcolumn=101    " Long line marker
set linebreak          " Only break lines between words
set formatoptions=crqj " c: Break long comments. q: Allow gq paragraph formatting. j: Remove comment
                       " mark when joining lines.

syntax enable             " Syntax highlighting
filetype plugin indent on " Enable all language-specific niceties
set nowrap                " Do not wrap long lines

set scrolloff=999   " Keep current line in middle of screen
set sidescrolloff=8 " Horizontal buffer columns around cursor
" }}}
" Editor appearance {{{
set number
set relativenumber

" Use gruvbox if available
try
	let g:gruvbox_contrast_dark  = 'hard'
	let g:gruvbox_contrast_light = 'hard'
	let g:gruvbox_italic         = 1  
	let g:gruvbox_guisp_fallback = 'bg' " To enable proper highlighting (see gruvbox issue #175)
	colorscheme gruvbox
" Don't do anything if gruvbox isn't available
catch /E185/
	"
endtry

set noshowmode    " Always show the status line
set laststatus=2  " Don't show mode on the command line, since it's on the status line
" }}}
" Perfomance tweaks {{{
set updatetime=200  " 200ms updates instead of 4s
" }}}
" Folding {{{
set foldenable
set foldmethod=syntax " Fold based on syntax rules
set foldlevelstart=1  " Start with most folds closed
"}}}
" Window splits {{{
set splitbelow " New window placed below
set splitright " New window placed to right
set fillchars+=vert:┃
"}}}
" Searching {{{
set ignorecase " Case-insensitive search by default
set smartcase  " Unless the pattern contains upper case

" Clear highlighting
nnoremap <Leader>c :nohlsearch<CR><C-L>
"}}}
" Spell check {{{
set spell             " Enable spell-checking
set spelllang=en_ca   " Spelling in English
set spellsuggest=best " Fast suggestions for English
"}}}
" Maps {{{
let mapleader=' '
let maplocalleader=','

" Clear highlighting
nnoremap <Leader>c :nohlsearch<CR><C-L>

" Easy return to normal mode
inoremap jk <Esc>
inoremap kj <Esc>

" Mnemonic maps for horizontal and vertical splits.
nnoremap <C-w>_ :split<CR>
nnoremap <C-w>\ :vsplit<CR>
" }}}
" }}}
" Plugins {{{
call plugpac#begin()
" Required for plugpac.vim {{{
Pack 'k-takata/minpac', {'type': 'opt'}
" }}}
call plugpac#end()
" }}}
