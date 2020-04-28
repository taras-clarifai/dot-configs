filetype plugin on
filetype indent on
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" automatically save on build/make
set autowrite
" allow to change buffer with unsaved changes
set hidden
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" disable autoindenting when pasting - press F2
set pastetoggle=<F2>
" Maintain undo history between sessions
set undofile
set cinoptions=g0,t0,(0,(s,j1,N0,b1
"map <C-K> :pyf C:\Program Files\LLVM\share\clang\lang-format.py<cr>
"imap <C-K><c-o>:pyf C:\Program Files\LLVM\share\clang\clang-format.py<cr>
" set automatically in cpp files
" set cindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" display lines as wrapped
set wrap
highlight ColorColumn ctermbg=lightgrey guibg=#303030
set colorcolumn=120
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
" set textwidth=120
" set the working directory to wherever the open file lives
" set autochdir
autocmd BufEnter * silent! lcd %:p:h
"autocmd BufEnter * lcd %:p:h
" turn syntax highlighting on
syntax on
" show eol
set listchars=eol:$,tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:+
set list
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" set folding based on syntax
" set foldenable
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
" highlight current line
set cursorline
" ignore case on autocomplete
set ignorecase
set infercase
set smartcase
" highlight search
set hlsearch
" backspace fix
set backspace=indent,eol,start
" when scrolling keep cursor 3 lines off screen
set scrolloff=3
" disable vim debug mapping
let g:vim_debug_disable_mappings = 1

" autoreload files on buffer enter
set autoread
au FocusGained,BufEnter * silent! checktime

" line movement like Qt Creator
nnoremap <S-C-Up> :m-2<CR>
nnoremap <S-C-Down> :m+<CR>

nnoremap <S-C-J> <C-W><C-J>
nnoremap <S-C-K> <C-W><C-K>
nnoremap <S-C-L> <C-W><C-L>
nnoremap <S-C-H> <C-W><C-H>

map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <c-w><Esc>l
imap <M-Left> <c-w><Esc>h
imap <M-Up> <c-w><Esc>k
imap <M-Down> <c-w><Esc>j

set sessionoptions=blank,buffers,curdir,folds,globals,options,resize,tabpages,winsize
" Automatically save the session when leaving Vim
autocmd! VimLeave * mksession! ~/.vim/default_session.vim
" Automatically load the session when entering vim
autocmd! VimEnter * source ~/.vim/default_session.vim

" tags for C++
set notagrelative
set tags+=~/.vim/tags/cpp
set tags+=./tags,tags;

" autocompletion options
set wildmenu
set wildignorecase
set wildmode=longest:list,full
" set wildcharm=<tab>.

" Enter to select item from completion popup
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

if has("gui_running")
    set guioptions=icpM
    if has('win32') || has('win64')
        if (v:version == 704 && has("patch393")) || v:version > 704
            set renderoptions=type:directx,level:0.5,gamma:1.5,contrast:0.25,geom:1,renmode:5,taamode:1
            set guifont=Consolas:h11
        endif
    endif
endif

if has('win32') || has('win64')
    set ff=dos
endif

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Find in files in current dir
command! -bang -nargs=* FindInFiles
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0] }, 'up:60%')
  \           : fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0] }, 'right:50%:hidden', '?'),
  \   <bang>0)

let mapleader = ","

nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>t :exec 'BTags '.expand('<cword>')<CR>
nmap <Leader>T :exec 'Tags '.expand('<cword>')<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>a :Ag<Space>
nmap <Leader>H :Helptags!<CR>
nmap <Leader>C :Commands<CR>
nmap <Leader>: :History:<CR>
nmap <Leader>/ :History/<CR>
nmap <Leader>s :exec 'Rg '.expand('<cword>')<CR>
nmap <Leader>S :exec 'FindInFiles '.expand('<cword>')<CR>
nmap <Leader>o :exec 'GGrep \(FIXME\)\\|\(TODO\)'<CR>
nmap <Leader>r :%s/\<<C-r><C-w>\>/

" `gf` opens file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<CR>

" global (for current buffer) search and replace with confirmation
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
" goto definition with F12
nnoremap <F12> g]

map <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Dash (documentation)
Plug 'rizzatti/dash.vim'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeFind' }

" Fuzzy-everything
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

Plug 'dense-analysis/ale'
" Beauty
Plug 'romainl/Apprentice'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editing
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'

" C++ specific
" Plug 'FromtonRouge/OmniCppComplete'
Plug 'octol/vim-cpp-enhanced-highlight'

" Initialize plugin system
call plug#end()

colorscheme apprentice
let g:airline_theme='deus'
let g:airline#extensions#ale#enabled = 1

" show global menu
set guioptions+=m

map <F8> :NERDTree<Space>%<CR>

" OmniCppComplete
"au BufNewFile,BufRead,BufEnter *.cpp,*.hpp,*.c,*.h set omnifunc=omni#cpp#complete#Main
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 0 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 0 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 0 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest

if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else " no gui
  if has("unix")
    inoremap <Nul> <C-x><C-o>
  endif
endif

" C++ highlighting
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let c_no_curly_error=1

" C++ include file search
" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

"let g:SuperTabDefaultCompletionType = "context"

" Dash
nmap <silent> <Leader>D <Plug>DashSearch

" Golang
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_def_mode = 'godef'
let g:go_auto_type_info = 1
" let g:go_auto_sameids = 1
let g:go_list_type = "quickfix"
let g:go_test_timeout = '10s'
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "camelcase"
let g:go_autodetect_gopath = 1
let g:go_bin_path = $CLARIFAI_ROOT."/go/bin"

" Linting
nmap <silent> <C-e> <Plug>(ale_next_wrap)
nmap <Leader>a :ALELint<CR>
let g:ale_linters = {'go': ['gopls', 'gofmt', 'go build', 'golangci-lint']}
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_echo_cursor = 1
let g:ale_sign_highlight_linenrs = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

autocmd FileType go setlocal tabstop=2        " tab width is 4 spaces
autocmd FileType go setlocal shiftwidth=2     " indent also with 4 spaces
autocmd FileType go setlocal noexpandtab
" go autocomplete
au filetype go inoremap <buffer> . .<C-x><C-o>
autocmd FileType go nmap <leader>c :<C-u>call <SID>build_go_files()<CR>
" autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <F12> <Plug>(go-def)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
"autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

