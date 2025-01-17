call pathogen#infect()
let mapleader = "\<Space>"
set nocompatible
set nomodeline
set viminfo='1000,f1,:1000,/1000
set history=1000
" set updatetime=750
scriptencoding utf-8
set encoding=utf-8
let g:signify_update_on_focusgained = 1


"------  Visual Options  ------
syntax on
set number
set nowrap
set vb
set ruler
set statusline=%<%f\ %h%m%r%=%{fugitive#statusline()}\ \ %-14.(%l,%c%V%)\ %P

" New splits open to right and bottom
set splitbelow
set splitright

" Toggle whitespace visibility with ,s
nmap <Leader>s :set list!<CR>
set listchars=tab:>\ ,trail:·,extends:»,precedes:«,nbsp:×
:set list " Enable by default

" <Leader>L = Toggle line numbers
map <Leader>L :set invnumber<CR>

" The search for the perfect color scheme...
map <silent> <Leader>x :RandomColorScheme<CR>

" Goyo display only current buffer for distraction-free writing
map <silent> <Leader>G :Goyo<CR>


"------  Generic Behavior  ------
set tabstop=4
set shiftwidth=4
set hidden
filetype indent on
filetype plugin on
set autoindent

"allow deletion of previously entered data in insert mode
set backspace=indent,eol,start

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" Edit and Reload .vimrc files
nmap <silent> <Leader>ev :e $MYVIMRC<CR>
nmap <silent> <Leader>es :so $MYVIMRC<CR>

" When pressing <Leader>cd switch to the directory of the open buffer
map ,cd :cd %:p:h<CR>


"------  Disable Annoying Features  ------
" Wtf is Ex Mode anyways?
nnoremap Q <nop>

" Annoying window
map q: :q

" Accidentally pressing Shift K will no longer open stupid man entry
noremap K <nop>


"------  Clipboard  ------
" Allow Shift+Insert to paste
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
" set clipboard=unnamedplus

" Copy filename
:nmap yY :let @" = expand("%")<CR>

" Copy file path
:nmap yZ :let @" = expand("%:p")<CR>

" F2 = Paste Toggle (in insert mode, pasting indented text behavior changes)
set pastetoggle=<F2>



"------  Text Navigation  ------
" Prevent cursor from moving to beginning of line when switching buffers
set nostartofline

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" yyp / yyP will retain column number
" https://vi.stackexchange.com/questions/18116/p-paste-but-keep-cursor-same-column
function! Pcol(...) abort
	let a:above = get(a:, 1, 0)
	let l:col = virtcol('.')
	execute 'normal!' a:above ? 'P' : 'p'
	call cursor('.', l:col)
endfunction
nnoremap <silent> p :call Pcol(0)<CR>
nnoremap <silent> P :call Pcol(1)<CR>

" H = Home, L = End
noremap H ^
noremap L $
vnoremap L g_


"------  Split Navigation  ------
" <Leader>hljk = Move between splits
nnoremap <Leader>h <C-w>h
nnoremap <Leader>l <C-w>l
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k


"------  Buffer Navigation  ------
" Ctrl+h & Ctrl+l cycle between buffers in the current split
noremap <silent> <C-h> :bprev<CR>
noremap <silent> <C-l> :bnext<CR>

" <Leader>q Closes the current buffer
nnoremap <silent> <Leader>q :Bclose<CR>

" <Leader>Q Closes the current window
nnoremap <silent> <Leader>Q <C-w>c

" <Leader>Ctrl+q Force Closes the current buffer
nnoremap <silent> <Leader><C-q> :Bclose!<CR>

" `g f` will open the filepath under the cursor in current split
" `Ctrl+w f` will open that same filepath in a horizontal split
" this allows `g F` to open it in a vertical split
:nnoremap gF :vertical wincmd f<CR>

"------  Searching  ------
set incsearch
set ignorecase
set smartcase
set hlsearch

" Clear search highlights when pressing <Leader>b
nnoremap <silent> <leader>b :nohlsearch<CR>

" http://www.vim.org/scripts/script.php?script_id=2572
" <Leader>a will open a prmompt for a term to search for
noremap <leader>a :Ack 

" <Leader>A will close the Ack split
noremap <leader>A <C-w>j<C-w>c<C-w>l

let g:ackprg="ag --vimgrep --column"

" CtrlP will load from the CWD, makes it easier with all these nested repos
let g:ctrlp_working_path_mode = ''

" CtrlP won't show results from node_modules
let g:ctrlp_custom_ignore = '\v[\/](node_modules|coverage|target|dist)|(\.(swp|ico|git|svn|png|jpg|gif|ttf))$'

"type S, then type what you're looking for, a /, and what to replace it with
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>


"------  NERDTree Options  ------
let NERDTreeIgnore=['CVS','\.dSYM$', '.git', '.DS_Store', '\.swp$', '\.swo$']

"setting root dir in NT also sets VIM's cd (useful for switching projects)
let NERDTreeChDirMode=2

" Toggle visibility using <Leader>n
noremap <silent> <Leader>n :NERDTreeToggle<CR>
" Focus on NERDTree using <Leader>m
noremap <silent> <Leader>m :NERDTreeFocus<CR>
" Focus on NERDTree with the currently opened file with <Leader>M
noremap <silent> <Leader>M :NERDTreeFind<CR>

" These prevent accidentally loading files while focused on NERDTree
autocmd FileType nerdtree noremap <buffer> <c-h> <nop>
autocmd FileType nerdtree noremap <buffer> <c-l> <nop>

" Open NERDTree if we're executing vim without specifying a file to open
autocmd vimenter * if !argc() | NERDTree | endif

" Hides "Press ? for help"
let NERDTreeMinimalUI=1

" Shows invisibles
let g:NERDTreeShowHidden=1


"------ NERDCommenter Options ------
" Visual select text then use 'Leader c Leader' to comment the selection
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'


"------  Fugitive Plugin Options  ------
"https://github.com/tpope/vim-fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gr :Gremove<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gm :Gmove 
nnoremap <Leader>gp :Ggrep 
nnoremap <Leader>gR :Gread<CR>
nnoremap <Leader>gg :Git 
nnoremap <Leader>gd :Gdiff<CR>


"------  Text Editing Utilities  ------
" <Leader>T = Delete all Trailing space in file
nmap <Leader>T :%s/\s\+$//<CR>

" <Leader>U = Deletes Unwanted empty lines
nmap <Leader>U :g/^$/d<CR>

" <Leader>R = Converts tabs to spaces in document
nmap <Leader>R :retab<CR>

" gq will wrap lines, so gQ will unwrap lines
nmap gQ VipJ


"------  JSON Filetype Settings  ------
au BufRead,BufNewFile *.json set filetype=json
let g:vim_json_syntax_conceal = 0
nmap <silent> =j :%!python -m json.tool<CR>:setfiletype json<CR>
autocmd BufNewFile,BufRead *.webapp set filetype=json
autocmd BufNewFile,BufRead *.jshintrc set filetype=json
autocmd BufNewFile,BufRead *.eslintrc set filetype=json


"------  Flow Filetype Settings  ------
let g:javascript_plugin_flow = 1
au BufNewFile,BufRead *.flow set filetype=javascript


"------  Markdown Settings  ------
let g:vim_markdown_folding_disabled = 1
let g:pencil#wrapModeDefault = 'soft'
autocmd FileType markdown setlocal spell " spell check markdown files
autocmd FileType markdown call pencil#init()


"------  Lightline Settings ------
let g:lightline = {
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'readonly', 'filename', 'modified', 'wc' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'fugitive#statusline',
	\   'wc': 'WordCount'
	\ },
	\ }


"------  Word Count  ------
function! WordCount()
  let s:old_status = v:statusmsg
  let position = getpos(".")
  exe ":silent normal g\<c-g>"
  let stat = v:statusmsg
  let s:word_count = 0
  if stat != '--No lines in buffer--'
    let s:word_count = str2nr(split(v:statusmsg)[11])
    let v:statusmsg = s:old_status
  end
  call setpos('.', position)
  return s:word_count
endfunction


"------  Text File Settings  ------
:autocmd! BufNewFile,BufRead * setlocal nowrap
:autocmd! BufNewFile,BufRead *.txt,*.md,*.tex setlocal wrap


let g:signify_realtime = 1

"------  GUI Options  ------
if has("gui_running")
	" Hides toolbar and scrollbars and File menu
	set guioptions=gt

	colorscheme hybrid

	" Ctrl+A select all
	map <C-a> ggVG

	" Ctrl+C OS clipboard copy
	vmap <C-c> "+y

	" Ctrl+B OS Clipboard paste
	map <C-b> "*p
	imap <C-b> "*p

	" Highlights the current line background
	set cursorline

	" Open VIM in fullscreen window
	" ...Unless you have dualscreens, then it's bigger than a screen...
	"set lines=200 columns=500
	set lines=60 columns=200

	" Build all help tags (slower launch, but I run GUI vim like once per day)
	call pathogen#helptags()

	" Set default starting directory to ~/Projects or ~/projects
	silent! cd $HOME/Projects
	silent! cd $HOME/projects

	if has("gui_macvim") " OS X
		set guifont=Monaco:h10
		set noantialias
		"set transparency=15

		" Swipe to move between buffers
		map <silent> <SwipeLeft> :bprev<CR>
		map <silent> <SwipeRight> :bnext<CR>

		" Cmd+P = CtrlP
		" TODO: This doesn't actually work, still opens Print dialog
		macmenu File.Print key=<nop>
		nnoremap <silent> <D-p> :CtrlP<CR>

		" Damn you scrollwheel paste
		nnoremap <MiddleMouse> <Nop>
		nnoremap <2-MiddleMouse> <Nop>
		nnoremap <3-MiddleMouse> <Nop>
		nnoremap <4-MiddleMouse> <Nop>

		inoremap <MiddleMouse> <Nop>
		inoremap <2-MiddleMouse> <Nop>
		inoremap <3-MiddleMouse> <Nop>
		inoremap <4-MiddleMouse> <Nop>
	elseif has("gui_gtk") " Linux
		" set guifont=monospace\ 9
		set guifont=ProggyCleanTT\ 12

		let g:NERDTreeDirArrowExpandable = '+'
		let g:NERDTreeDirArrowCollapsible = '~'
	endif
else
	" Inside of a terminal
	set t_Co=256
	colorscheme ir_black
	set mouse=a
endif


"------  Local Overrides  ------
if filereadable($HOME.'/.vim/local.vimrc')
	source $HOME/.vim/local.vimrc
endif
