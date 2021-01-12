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
" Performance tweaks {{{
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
" Look and feel {{{
Pack 'gruvbox-community/gruvbox', {'type': 'opt'}
" }}}
" External tools {{{
" FZF {{{
Pack 'junegunn/fzf'     " Fuzzy file search
Pack 'junegunn/fzf.vim'
nnoremap <silent> <Leader>e :Files<CR>
" }}}
" ALE {{{
Pack 'w0rp/ale'                                  " Linter/fixer integration
let g:ale_loclist_msg_format='%%s (%linter%%: code%)'
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_insert_leave=1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}

nnoremap ]e :ALENextWrap<CR>
nnoremap [e :ALEPreviousWrap<CR>
" }}}
" gitgutter {{{
Pack 'airblade/vim-gitgutter'                    " Git diff in margin
let g:gitgutter_map_keys = 0  " Disable key maps
" }}}
Pack 'tpope/vim-fugitive'                        " Git integration
" }}}
" Multi-language {{{
Pack 'tyru/caw.vim'            " Language-aware commenting
Pack 'machakann/vim-sandwich'  " Change surrounding delimiters
Pack 'jiangmiao/auto-pairs'
" UltiSnips {{{
Pack 'sirver/ultisnips'        " Snippet expansion
let g:UltiSnipsExpandTrigger       = '<Tab>'
let g:UltiSnipsExpandTrigger       = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsSnippetDirectories  = [$VIMHOME . '/UltiSnips']
let g:UltiSnipsEditSplit           = 'context'
" }}}
" tagbar {{{
Pack 'majutsushi/tagbar'       " Tag navigation window
nnoremap <Leader>t :TagbarToggle<CR>
let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_compact=1
" }}}
Pack 'konfekt/fastfold'        " Faster code-folding (for vimtex)
Pack 'andymass/vim-matchup'    " More powerful matching (for vimtex)
" vim-illuminate {{{
Pack 'RRethy/vim-illuminate'   " Highlight word under cursor
let g:Illuminate_delay = 50
" }}}
" }}}
" Python {{{
Pack 'tweekmonster/braceless.vim'   " Text objects and indents
Pack 'kalekundert/vim-coiled-snake' " Folds
" }}}
" LaTeX {{{
" vimtex {{{
Pack 'lervag/vimtex'                  " Highlighting, viewer integration, commands
let tex_flavor = 'latex'
" }}}
Pack 'KeitaNakamura/tex-conceal.vim'  " Improved TeX conceal
" }}}
" SQL {{{
Pack 'lifepillar/pgsql.vim'  " Improved PostgreSQL highlighting
" }}}
" }}}
