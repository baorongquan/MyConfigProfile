"author rongquan.bao@gmail.com

set nocompatible
set nu
filetype off
syntax enable		" enable syntax processing 
set background=dark 
set tabstop=4		" number of visual spaces per TAB 
set shiftwidth=4	
set softtabstop=4	" number of spaces in tab when editing 
"set expandtab		" tabs are spaces 
set cursorline		" highlight current line 
set wildmenu		" visual autocomplete for command 
set lazyredraw		" redraw only when we need to 
set incsearch		" search as characters are entered 
set nohlsearch		" highlight matches
" turn off search highlight 
nnoremap <leader><space> :nohlsearch<CR>
set foldenable		" enable folding
set foldlevelstart=10	" open most folds by default 
set foldnestmax=10		" 10 nested fold max 
set foldmethod=indent 
"space open/closes folds 
nnoremap <space> za
nnoremap j gj 
nnoremap k gk
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>
" highlight last inserted text 
nnoremap gV `[v`]

let mapleader=","		"leader is comma
" jk is escape 
inoremap jk <esc>

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'Valloric/ListToggle'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'Chiel92/vim-autoformat'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'git://git.wincent.com/command-t.git'
"Plugin 'mbbill/echofunc'
Plugin 'quickfix/quickfix'
Plugin 'majutsushi/tagbar'
"Plugin 'mileszs/ack.vim'
Plugin 'https://github.com/sjl/gundo.vim.git'
Plugin 'https://github.com/rking/ag.vim'
Plugin 'fatih/vim-go'
Plugin 'dgryski/vim-godef'
Plugin 'Blackrush/vim-gocode'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plugin 'majutsushi/tagbar'
call vundle#end()
filetype plugin indent on

"set youcomplete
set completeopt=preview,menu
autocmd InsertLeave * if pumvisible()==0|pclose|endif
inoremap <expr> <CR> pumvisible() ? "\<C-y>":"\<CR>" 
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
let g:ycm_key_list_select_completion = ['<c-n>',"<Down>"]
let g:ycm_key_list_previous_completion = ['<c-m>',"<Up>"]
let g:ycm_key_invoke_completion='<M-;>'
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.c = ['->','.',' ','(','[','&']
let g:ycm_confirm_extra_conf=0

let g:ycm_use_ultisnips_completer=1
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_cache_omnifunc=0 
let g:ycm_seed_identifiers_with_syntax=1 
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_collect_identifiers_from_comments_and_strings=0
let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"
nnoremap <leader>gt :YcmCompleter GoTo<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
function! MyTabFunction ()
let line = getline('.')
let substr = strpart(line, -1, col('.')+1)
let substr = matchstr(substr, "[^ \t]*$")
if strlen(substr) == 0
return "\<tab>"
endif
return pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>"
endfunction
inoremap <tab> <c-r>=MyTabFunction()<cr>
inoremap <c-o> <c-x><c-o>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-e>"
"let Tlist_Show_One_File=1
"let Tlist_Exit_OnlyWindow=1

let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
let g:syntastic_javascript_checkers = ['jsl', 'jshint']
let g:syntastic_html_checkers=['tidy', 'jshint']
" 修改高亮的背景色, 适应主题
highlight SyntasticErrorSign guifg=white guibg=black

" to see error location list
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
function! ToggleErrors()
	let old_last_winnr = winnr('$')
	lclose
	if old_last_winnr == winnr('$')
		"Nothing was closed, open syntastic error location panel Errors
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>"


nmap <F9> <Esc>:!ctags -R fields=+lS *<CR> 
set tags=tags 
set tags+=./tags; "set tags+=/usr/include/tags

let g:tagbar_left=1 "open list in left 
set updatetime=100 "根据光标位置自动更新高亮tag的间隔时间，单位毫秒
let g:tagbar_width=25 "设置窗口宽度
"let g:tagbar_show_linenumbers=1 
let g:tagbar_expand=1 "autocmd VimEnter * nested :call tagbar#autoopen(1) 若文件类型支持，则自动打开tagbar  
"autocmd BufEnter * nested :call tagbar#autoopen(0)  打开新标签时，自动打开tagbar


function! TAT() "ToggleTERDTreeAndTagbar()
let w:jumpbacktohere=1

 " Detect which plugins are open 
if exists('t:NERDTreeBufName')
	let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
else 
	let nerdtree_open = 0
endif
let tagbar_open = bufwinnr('__Tagbar__') != -1

 "Perform ther appropriate action 
if nerdtree_open && tagbar_open 
	NERDTreeClose
	TagbarClose
elseif nerdtree_open 
	TagbarOpen
	wincmd J 
	wincmd k
	wincmd l
	wincmd L
elseif tagbar_open 
	NERDTree 
	wincmd J
	wincmd k
	wincmd l
	wincmd L
else 
	NERDTree
	TagbarOpen
	wincmd K
	wincmd j
	wincmd l
	wincmd L
endif 

vertical resize +50
endfunction 

 "autocmd vimenter * call TAT()

 "=================
" open ag.vim 
set runtimepath^=~/.vim/bundle/ag
nnoremap <leader>a :Ag

" toggle gundo 
nnoremap <leader>u :GundoToggle<CR>

" go config 
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"


if $GOPATH != ''
	  " golint
	   execute "set rtp+=".globpath($GOPATH, "src/github.com/golang/lint/misc/vim")
	  " syntastic set
	  let g:syntastic_go_checkers = ['go', 'golint', 'govet']
endif

" powerline config
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
