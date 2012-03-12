" Contro variables for skipping some setup, can be set from .local
let g:skip_language_settings=0
let g:skip_pylint=0
let g:skip_omni_complete=0

" load per machine settings, missing file will be ignored.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

syntax on
filetype on

set background=dark
set nobackup
set nowritebackup
set noswapfile
set pastetoggle=<F10>

colorscheme peachpuff

" Avoid trailing spaces.
highlight WhitespaceEOL ctermbg=red guibg=red
autocmd BufWinEnter * match WhitespaceEOL /\s\+$/

if g:skip_language_settings==0
	autocmd FileType c,cpp,slang set cindent
	autocmd FileType c set formatoptions+=ro cindent
	autocmd FileType perl set smartindent ts=4 et shiftwidth=4
	autocmd FileType php set autoindent
	autocmd FileType css set smartindent
	autocmd FileType html set formatoptions+=tl tabstop=2 expandtab sw=2
	autocmd FileType css set noexpandtab tabstop=2
	autocmd FileType make set noexpandtab shiftwidth=8
	autocmd FileType xml set tabstop=2 expandtab
	autocmd FileType python set ts=4 et shiftwidth=4
	autocmd Filetype bash,sh set fo+=tl
	autocmd Filetype tex set fo+=tln
	autocmd FileType mail set com=s1:/*,mb:*,ex:*/,n:>,b:#,b:%,b:=,b:-,b:+,b:o fo=tqlnor
endif

if g:skip_pylint==0
	function! s:PyLint()
	  let a:lint = 'pylint --output-format=parseable --include-ids=y'
	  cexpr system(a:lint . ' ' . expand('%'))
	endfunction
	au FileType python command! Lint :call s:PyLint()
endif

if g:skip_omni_complete==0
	autocmd FileType python set omnifunc=pythoncomplete#Complete
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
endif

set wildmode=list:longest,full

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" * Text Formatting -- General

" don't make it look like there are line breaks where there aren't:
set nowrap

" Don't put comments on the first coloumn when indenting
inoremap # X#

" normally don't automatically format 'text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=t
set textwidth=79

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

" page down with <Space> (like in `Lynx', `Mutt', `Pine', `Netscape Navigator',
" `SLRN', `Less', and `More'); page up with - (like in `Lynx', `Mutt', `Pine'),
" or <BkSpc> (like in `Netscape Navigator'):
noremap <Space> <PageDown>
noremap <BS> <PageUp>
noremap - <PageUp>

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>

" have <F1> save current work and execute last command and do it from any mode:
nnoremap <F1> :w<cr>:!!<cr>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>


" * Keystrokes -- Formatting

" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq

" have the usual indentation keystrokes still work in visual and normal mode:
vnoremap <C-T> >
vnoremap <C-D> <LT>
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>
noremap <C-T> >
noremap <C-D> <LT>
map <Tab> <C-T>
map <S-Tab> <C-D>

" * Keystrokes -- Insert Mode

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" We play utf-8
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8
au BufNewFile,BufRead mutt*        set tw=77 ai nocindent fileencoding=utf-8
au BufNewFile,BufRead .drafts/*    set tw=77 ai nocindent fileencoding=utf-8

function! CleverTab()
	if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
		return "\<Tab>"
	else
		return "\<C-N>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
