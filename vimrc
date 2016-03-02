
""" Setup-neo-bundle -----------------------------------------------------------
let neoBundleReadMe=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neoBundleReadMe)
  echo "Fetch and install NeoBundle...\n"
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
endif

if has('vim_starting')
  set nocompatible " Be iMproved
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
  let g:make = 'make'
endif

""" Bundles --------------------------------------------------------------------

NeoBundle 'junegunn/vim-easy-align',       { 'on': ['<NeoBundle>(EasyAlign)', 'EasyAlign'] }
NeoBundle 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity']      }

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim',
  \ {
  \ 'build': {
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }

NeoBundle 'hewes/unite-gtags'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'chriskempson/tomorrow-theme'
NeoBundle 'bling/vim-airline'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'klen/python-mode'
NeoBundle 'chrisbra/csv.vim'
NeoBundle 'ivalkeen/vim-ctrlp-tjump'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'junegunn/limelight.vim'
NeoBundle 'FelikZ/ctrlp-py-matcher'
NeoBundle 'gerw/vim-latex-suite'

NeoBundle 'vim-erlang/vim-erlang-runtime'
NeoBundle 'vim-erlang/vim-erlang-tags'
NeoBundle 'vim-erlang/vim-erlang-compiler'
NeoBundle 'vim-erlang/vim-erlang-omnicomplete'

NeoBundle 'sickill/vim-monokai'

""" neo-bundle-settings --------------------------------------------------------
call neobundle#end()
" Required:
filetype plugin indent on
NeoBundleCheck
let mapleader = " "

""" airline --------------------------------------------------------------------
set laststatus=2
let g:airline_powerline_fonts = 1

""" python-mode ----------------------------------------------------------------

let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
"
" "Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
" Auto check on save
let g:pymode_lint_write = 1
"
" " Support virtualenv
let g:pymode_virtualenv = 1
"
" " Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
"
" " syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
" " Don't autofold code
let g:pymode_folding = 0
"

""" signify --------------------------------------------------------------------
let g:signify_vcs_list = 1

""" Do not override term colorsheme -------------------------------------
hi Normal ctermbg=none
highlight NonText ctermbg=none

""" ctrlp ----------------------------------------------------------------------
let g:ctrlp_working_path_mode = 'c'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" Open goto symbol on current buffer
  nmap <c-r> :MyCtrlPTag<cr>
  imap <c-r> <esc>:MyCtrlPTag<cr>

  " Open goto symbol on all buffers
  nmap <c-R> :CtrlPBufTagAll<cr>
  imap <c-R> <esc>:CtrlPBufTagAll<cr>

nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>

""" trailing whitespace --------------------------------------------------------
let g:extra_whitespace_ignored_filetypes = ['unite']

""" MiniBufExplorer ------------------------------------------------------------
nnoremap <silent> <F3> :TMiniBufExplorer<CR>
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 0
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25
let g:miniBufExplSplitBelow=1

""" Limelight ------------------------------------------------------------------
let g:limelight_conceal_ctermfg = 'darkgray'

""" Unite ----------------------------------------------------------------------
nnoremap [unite] <Nop>
nmap <Leader><Leader> [unite]
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
    \ 'ignore_pattern', join([
        \ '\.git/',
        \ '\.sass-cache/',
        \ '\.tmp/',
        \ '\vendor/',
        \ '\node_modules/',
    \ ], '\|'))


nnoremap [unite]f :<C-u>Unite -start-insert file_rec/async:!<CR>

" Unite: unite-source-history/yank
let g:unite_source_history_yank_enable = 1
nnoremap [unite]y :<C-u>Unite history/yank<CR>

" Unite: neosnippet-unite-source-neosnippet
nnoremap [unite]s :<C-u>Unite neosnippet<CR>

" Unite: unite-source-grep
let g:unite_source_grep_max_candidates = 200
if executable('ag')

" Use ag in unite grep source.
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
\ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')

" Use pt in unite grep source.
" https://github.com/monochromegane/the_platinum_searcher
let g:unite_source_grep_command = 'pt'
let g:unite_source_grep_default_opts = '-i --nogroup --nocolor'
let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')

" Use ack in unite grep source.
let g:unite_source_grep_command = 'ack-grep'
let g:unite_source_grep_default_opts =
\ '-i --no-heading --no-color -k -H'
let g:unite_source_grep_recursive_opt = ''
endif

nnoremap [unite]ug :<C-u>Unite grep:.:-iIR:<CR>
" '_' in key means default configuration.
nnoremap [unite]gx :<C-u>Unite gtags/context<CR>
nnoremap [unite]gr :<C-u>Unite gtags/ref<CR>
nnoremap [unite]gd :<C-u>Unite gtags/def<CR>
nnoremap [unite]gg :<C-u>Unite gtags/grep<CR>
nnoremap [unite]gc :<C-u>Unite gtags/completion<CR>

nnoremap [unite]gX :<C-u>Unite gtags/context:
nnoremap [unite]gR :<C-u>Unite gtags/ref:
nnoremap [unite]gD :<C-u>Unite gtags/def:
nnoremap [unite]gG :<C-u>Unite gtags/grep:
nnoremap [unite]gC :<C-u>Unite gtags/completion:

nnoremap [unite]gs :GtagsCursor<CR>
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap [unite]s :Unite -quick-match buffer<cr>
nnoremap [unite]a :<C-u>Unite grep:.<CR>
nnoremap [unite]A :<C-u>execute 'Unite grep:.::' . expand("<cword>") . ''<CR>
map [unite]t :!~/packages/dotvim/make_tags<cr>:Unite -no-split -start-insert tag<cr>

nnoremap [unite]t :Unite tag -start-insert<CR>

nnoremap <Leader>gn :Unite output:echo\ system("git\ init")<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>go :Gread<CR>
nnoremap <Leader>gR :Gremove<CR>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gB :Gbrowse<CR>
nnoremap <Leader>gp :Git! push<CR>
nnoremap <Leader>gP :Git! pull<CR>
nnoremap <Leader>gi :Git!<Space>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gE :Gedit<Space>
nnoremap <Leader>gl :exe "silent Glog <Bar> Unite -no-quit
\ quickfix"<CR>:redraw!<CR>
nnoremap <Leader>gL :exe "silent Glog -- <Bar> Unite -no-quit
\ quickfix"<CR>:redraw!<CR>
nnoremap <Leader>gt :!tig<CR>:redraw!<CR>
nnoremap <Leader>gS :exe "silent !shipit"<CR>:redraw!<CR>
nnoremap <Leader>gg :exe 'silent Ggrep -i '.input("Pattern: ")<Bar>Unite
\ quickfix -no-quit<CR>
nnoremap <Leader>ggm :exe 'silent Glog --grep='.input("Pattern: ").' <Bar>
\Unite -no-quit quickfix'<CR>
nnoremap <Leader>ggt :exe 'silent Glog -S='.input("Pattern: ").' <Bar>
\Unite -no-quit quickfix'<CR>
nnoremap <Leader>ggc :silent! Ggrep -i<Space>
" for the diffmode
noremap <Leader>du :diffupdate<CR>
if !exists(":Gdiffoff")
command Gdiffoff diffoff | q | Gedit
endif
noremap <Leader>dq :Gdiffoff<CR>
" }}}
" Gitv {{{
nnoremap <silent> <leader>gv :Gitv --all<CR>
nnoremap <silent> <leader>gV :Gitv! --all<CR>
vnoremap <silent> <leader>gV :Gitv! --all<CR>
let g:Gitv_OpenHorizontal = 'auto'
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_DoNotMapCtrlKey = 1
" let g:Gitv_WrapLines = 1
autocmd FileType git set nofoldenable
" }}}
" GitHub dashboard {{{
nnoremap <Leader>gD :exe 'GHD! '.input("Username: ")<CR>
nnoremap <Leader>gA :exe 'GHA! '.input("Username or repository: ")<CR>
function! GHDashboard (...)
if &filetype == 'github-dashboard'
" first variable is the statusline builder
let builder = a:1
call builder.add_section('airline_a', 'GitHub ')
call builder.add_section('airline_b',
\ ' %{get(split(get(split(github_dashboard#statusline(), " "),
\ 1, ""), ":"), 0, "")} ')
call builder.add_section('airline_c',
\ ' %{get(split(get(split(github_dashboard#statusline(), " "),
\ 2, ""), "]"), 0, "")} ')
" tell the core to use the contents of the builder
return 1
endif
endfunction
autocmd FileType github-dashboard call airline#add_statusline_func('GHDashboard')


""" NerdCommenter --------------------------------------------------------------
" Map <C-/> to toggle comment both in normal and visual mode
nmap  <plug>NERDCommenterToggle
vmap  <plug>NERDCommenterToggle

""" Easytags -------------------------------------------------------------------
let g:easytags_cmd = "gtags"
let g:easytags_dynamic_files = 1
let g:easytags_async = 1

""" Tabularize -----------------------------------------------------------------
nmap <silent> <leader>a= :<C-u>Tabularize /=<CR>
vmap <silent> <leader>a= :<C-u>Tabularize /=<CR>
nmap <silent> <leader>a: :<C-u>Tabularize /:<CR>
vmap <silent> <leader>a: :<C-u>Tabularize /:<CR>
nmap <silent> <leader>a:: :<C-u>Tabularize /:\zs<CR>
vmap <silent> <leader>a:: :<C-u>Tabularize /:\zs<CR>
nmap <silent> <leader>a, :<C-u>Tabularize /,<CR>
vmap <silent> <leader>a, :<C-u>Tabularize /,<CR>

""" NerdTree -------------------------------------------------------------------
nnoremap <silent> <F2> :NERDTreeToggle<CR>
":let NERDTreeQuitOnOpen = 1
""" Tagbar ---------------------------------------------------------------------
let g:tagbar_sort = 0 " Display tags the same order they appear in the source file
let g:tagbar_width = 30 " Set Tagbar window width to 30
let g:tagbar_autofocus = 1 " Change the focus to the Tagbar window whenever it is opened
nnoremap <silent> <F9> :TagbarToggle<CR>

""" Fugitive -------------------------------------------------------------------
set diffopt=filler,vertical
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gp :Git push<CR>
nmap <silent> <leader>gs :Gstatus<CR>
nmap <silent> <leader>gb :Gblame<CR>

""" a.vim ----------------------------------------------------------------------
map <silent> <C-Tab> :A<CR>
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "normal g`\"" |
\ endif

""" Gtags-find -----------------------------------------------------------------
let search_max = 20
if exists("$GTAGSGLOBAL") || exists(":global")
  if exists("vimrc_debug") && vimrc_debug == 1
    echo "Searching GPATH, GTAGS, and GRTAGS ..."
  endif
  let s:dir = fnamemodify(getcwd(), ":p:h")
  let i = 1
  while i <= search_max
    if exists("vimrc_debug") && vimrc_debug == 1
      echo s:dir
    endif
    if filereadable(s:dir . "/GPATH") && filereadable(s:dir . "/GTAGS") && filereadable(s:dir . "/GRTAGS")
      let $GTAGSROOT = s:dir
      let GtagsCscope_Auto_Load = 1
      break
    elseif s:dir == '/'
      break
    else
      let s:dir = fnamemodify(s:dir, ":h")
      let i += 1
    endif
  endwhile
endif

""" Cscope-settings ------------------------------------------------------------
 if filereadable("GTAGS")
     set csprg=gtags-cscope
     cs add GTAGS
 elseif filereadable("cscope.out")
     cs add cscope.out
     "else add the database pointed to by environment variable
 elseif $CSCOPE_DB !=""
     cs add $CSCOPE_DB
 endif

 set csto=0
 set cscopeverbose
 " key mapping
 map <S-F11> <ESC>:cs add cscope.out<CR>
 map <C-F11> <ESC>:cscope find
 " 's' symbol: find all references to the token under cursor
 " 'g' global: find global definition(s) of the token under cursor
 " 'c' calls: find all calls to the function name under cursor
 " 't' text: find all instances of the text under cursor
 " 'e' egrep: egrep search for the word under cursor
 " 'f' file: open the filename under cursor
 " 'i' includes: find files that include the filename under cursor
 " 'd' called: find functions that function under cursor calls
 map <F3>s <ESC>:cs find s <C-R>=expand("<cword>")<CR><CR>
 map <F3>g <ESC>:cs find g <C-R>=expand("<cword>")<CR><CR>
 map <F3>c <ESC>:cs find c <C-R>=expand("<cword>")<CR><CR>
 map <F3>t <ESC>:cs find t <C-R>=expand("<cword>")<CR><CR>
 map <F3>e <ESC>:cs find e <C-R>=expand("<cword>")<CR><CR>
 map <F3>f <ESC>:cs find f <C-R>=expand("<cfile>")<CR><CR>
 map <F3>i <ESC>:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
 map <F3>d <ESC>:cs find d <C-R>=expand("<cword>")<CR><CR>
 " split way
 nmap <C-F3>s :scs find s <C-R>=expand("<cword>")<CR><CR>
 nmap <C-F3>g :scs find g <C-R>=expand("<cword>")<CR><CR>
 nmap <C-F3>c :scs find c <C-R>=expand("<cword>")<CR><CR>
 nmap <C-F3>t :scs find t <C-R>=expand("<cword>")<CR><CR>
 nmap <C-F3>e :scs find e <C-R>=expand("<cword>")<CR><CR>
 nmap <C-F3>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
 nmap <C-F3>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
 nmap <C-F3>d :scs find d <C-R>=expand("<cword>")<CR><CR>
 " vsplit way
 nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
 nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
 nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
 nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
 nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
 nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
 nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
 nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

""" Basic-keybindings  --------------------------------------------------------
command Bd bp | sp | bn | bd

nmap <Leader>n  :MBEbp<CR>
nmap <Leader>m  :MBEbn<CR>
nmap <Leader>d  :Bd<CR>
nmap <Leader>f  :b

map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

""" Appearance ----------------------------------------------------------------
syntax on
hi Visual term=reverse cterm=reverse guibg=Grey
set encoding=utf8
set hlsearch
if has("gui_macvim")
set guifont=Menlo:h12
endif

""" Color-scheme --------------------------------------------------------------
if $COLORTERM == 'gnome-terminal'
set t_Co=256
endif
set background=dark
colorscheme Tomorrow-Night

""" Basic-settings ------------------------------------------------------------
set backspace=indent,eol,start
set history=50 " keep 50 lines of command line history
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching
set nobackup " Disable the creation of backup files (the ones ending with ~)
set mouse=a " enable mouse 'all'
set number " line numbers
set scrolloff=1 " Keep the cursor away from top/bottom
set wildmode=longest,list " TAB completion (such as bash)
set laststatus=2 " Always show a status bar
set ignorecase " needed for smartcase
set smartcase " Ignore case when search pattern is all lowercase
	"/copyright      " Case insensitive
	"/Copyright      " Case sensitive
	"/copyright\C    " Case sensitive
	"/Copyright\c    " Case insensitive
set shiftwidth=4 " # of spaces of auto indent
set softtabstop=4 " # of spaces of <TAB> key
set tabstop=4 " # of spaces erased when deleting a <TAB>
set expandtab " Insert spaces instead of tabs
set smarttab " 'siftwidth' in front of a line
set noswapfile     " No swap files
set nobackup       " No backups
set nowritebackup

" map <Leader>n <plug>NERDTreeTabsToggle<CR>
" Go to tab by number
" noremap <leader>1 1gt
" noremap <leader>2 2gt
" noremap <leader>3 3gt
" noremap <leader>4 4gt
" noremap <leader>5 5gt
" noremap <leader>6 6gt
" noremap <leader>7 7gt
" noremap <leader>8 8gt
" noremap <leader>9 9gt
" noremap <leader>0 :tablast<cr>

""" Vim-Indent-Guides ---------------------------------------------------------
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
highlight IndentGuidesOdd ctermbg=236 guibg=#3a3a3a
highlight IndentGuidesEven ctermbg=236 guibg=#3a3a3a
au VimEnter * :IndentGuidesEnable

""" Vim-Rainbow-Parentheses ---------------------------------------------------
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

""" latex mode --------------------------------------------------------------
filetype indent on
filetype plugin on
filetype on
let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*
let g:Tex_Folding=0 "I don't like folding.
set iskeyword+=:


""" fugitive shortcuts -------------------------------------------------------
noremap <Leader>gs :Gstatus<cr>
noremap <Leader>gc :Gcommit<cr>
noremap <Leader>ga :Gwrite<cr>
noremap <Leader>gl :Glog<cr>
noremap <Leader>gb :Gblame<cr>

function! SetupCtrlP()
    nnoremap <silent> <C-n> :CtrlPBuffer<CR>
    nnoremap <silent> <C-m> :CtrlP<CR>

    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
          \ --ignore .git
          \ --ignore .svn
          \ --ignore .hg
          \ --ignore .DS_Store
          \ --ignore "*.pyc"
          \ --ignore "*~"
          \ -g ""'

    let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_lazy_update = 250
    let g:ctrlp_max_files = 0
    let g:ctrlp_max_height = 30
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
    let g:ctrlp_match_window_bottom = 0
    let g:ctrlp_match_window_reversed = 0
    let g:ctrlp_switch_buffer = 0
endfunction
call SetupCtrlP()

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

function! GFM()
let langs = ['vim', 'c', 'cpp']

for lang in langs
unlet b:current_syntax
silent! exec printf("syntax include @%s syntax/%s.vim", lang, lang)
exec printf("syntax region %sSnip matchgroup=Snip start='```%s' end='```' contains=@%s",
             \ lang, lang, lang)
endfor
let b:current_syntax='mkd'
syntax sync fromstart
endfunction
