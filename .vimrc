"===============
" Settings 
"===============
set showcmd 		" Display command
set background=dark " If using a dark background within the editing area and syntax highlighting
set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=a	    " Enable mouse usage (all modes)
set mousehide       " Hides mouse
set shell=/bin/bash\ -l "set the shell
set number		    " Shows number on the side on the right side
set relativenumber  " Changes the way that numbers are place on the side
set ruler		    " Display Info on the lower right side
set hlsearch		" Search highlight
set clipboard=unnamed " set paste clipboard to system's
set shell=bash                 "set right shell for vim --this is use to run Asyncrun
set ch=2 			" Two line for the line command
set vb 		        " Don't make noices
set cpoptions=Bces$ " Put '$' at the end of the changing string
set laststatus=2    " Show status line
set lazyredraw 		" Don't update when writting macros
set showmode 		" Display mode
set history=300  	" Store the last 100 commands
set virtualedit=all " Lets you go to undefined places
set wildmenu 		" Better commandline completion
set textwidth=120 	" Set the maximun width for text
set diffopt+=iwhite " Ignore whitespace in diff
set fillchars=""    " Get rid of  window separators
set backspace=2     " Set backspacing over indent
set wrapscan        " Wrap around the page when searching 
set fdm=indent      " set folding method to indent
set synmaxcol=2048 " Syntax coloring lines that are too long just slows down the world
" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8
" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
set timeoutlen=500
set tabstop=2 shiftwidth=2 expandtab

"" Vim5 and later versions support syntax highlighting. Uncommenting the
"" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif
"
"" Map a new leader
let mapleader = ","
"
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Use Unicode in Files
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif


"Vim load indentation rules and plugins according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

"===============
" Mappings
"===============
" Press Space to turn off highlighting and clear any message already
" displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" Remove all the reference links in html
nnoremap <silent> ,c :%s/href=".[^>]*//g<Bar>:echo<CR>
" Align Everything
nnoremap <silent> =g :normal ggVG=''<Bar>:echo<CR>
" Toggle paste mode
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>
" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>
" Create the directory
nmap <silent> ,md :!mkdir -p %:p:h<CR>
" allow command line editing like emacs
" Highlight all instances of the current word under the cursor
nmap <silent> ^ :setl hls<CR>:let @/="<C-r><C-w>"<CR>
" Map CTRL-E to do what ',' used to do
nnoremap <c-e> ,
vnoremap <c-e> ,
" Buffer commands
noremap <silent> ,bd :bd<CR>
" Jump to next buffered file
nnoremap <silent><Tab> :bn<Bar>:echo "next buffered"<CR>
" Jump to previous buffered file
nnoremap <silent><S-Tab> :bp<Bar>:echo "previous buffered"<CR>
" Run the command that was just yanked
nmap <silent> ,rc :@"<cr>
" Underline the current line with '='
nmap <silent> ,ul :t.\|s/./=/g\|set nohls<cr>
" Delete all buffers
nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>
" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
" swap two words
nmap <silent> gw :s/\(\%"\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'
" set text wrapping toggles
nmap <silent> ,w :set invwrap<CR>:set wrap?<CR>
" Shortcut to rapidly toggle `set list`
nmap <silent> ,li :set list!<CR>
" Shortcut to view Pending task
nmap <silent> ,ta :TaskList<CR>
" build tags of your own project with Ctrl-F12
nmap <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" allow command line editing like emacs
cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <Down>
cnoremap <C-P>      <Up>
cnoremap <ESC>b     <S-Left>
cnoremap <ESC><C-B> <S-Left>
cnoremap <ESC>f     <S-Right>
cnoremap <ESC><C-F> <S-Right> cnoremap <ESC><C-H> <C-W>

" Maps to make handling windows a bit easier
noremap <silent> ,h :wincmd h<CR> 
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
noremap <silent> ,sb :wincmd p<CR> 
noremap <silent> ,f <C-W>o<CR> "Expands current window
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> ,s8 :vertical resize 83<CR>
noremap <silent> ,cj :wincmd j<CR>:close<CR>
noremap <silent> ,ck :wincmd k<CR>:close<CR>
noremap <silent> ,ch :wincmd h<CR>:close<CR>
noremap <silent> ,cl :wincmd l<CR>:close<CR>
noremap <silent> ,cc :close<CR>
noremap <silent> ,cw :cclose<CR>
noremap <silent> ,ml <C-W>L
noremap <silent> ,mk <C-W>K
noremap <silent> ,mh <C-W>H
noremap <silent> ,mj <C-W>J
noremap <silent> <C-7> <C-W>>
noremap <silent> <C-8> <C-W>+
noremap <silent> <C-9> <C-W>+
noremap <silent> <C-0> <C-W>

"================================
" Fix constant spelling mistakes
"================================
iab teh       the
iab Teh       The
iab taht      that
iab Taht      That
iab alos      also
iab Alos      Also
iab aslo      also
iab Aslo      Also
iab becuase   because
iab Becuase   Because
iab bianry    binary
iab Bianry    Binary
iab bianries  binaries
iab Bianries  Binaries
iab charcter  character
iab Charcter  Character
iab charcters characters
iab Charcters Characters
iab exmaple   example
iab Exmaple   Example
iab exmaples  examples
iab Exmaples  Examples
iab shoudl    should
iab Shoudl    Should
iab seperate  separate
iab Seperate  Separate
iab fone      phone
iab Fone      Phone

""======================
"" Vundle Settings
""======================
set nocompatible " be iMproved, required
filetype off     " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""""""""
"  PLUGINS    " 
"""""""""""""""
"Install Vundle git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
Plugin 'gmarik/Vundle.vim'               " let Vundle manage Vundle, required
Plugin 'tpope/vim-fugitive'              " Vim and git integration plugin
Plugin 'tpope/vim-surround'              " Surrounds text with quotes and other things. Great for html
Plugin 'tpope/vim-repeat'                " Allows the use of '.' for plugins
Plugin 'tpope/vim-unimpaired'               " Mappings to jump to errors
Plugin 'tpope/vim-sleuth'                   " Automatically adjusts spaces and tabs according to the file you are working on
Plugin 'Lokaltog/vim-easymotion'         " Plugin to move around a file by highlighting all possible choices
Plugin 'GabrieleLippi/ydkjs-vim'           " You don't know JS book as ViM Doc file
Plugin 'jiangmiao/auto-pairs'               " Close pairs like {} and [] and '' and 
Plugin 'godlygeek/tabular'               " Aligns text
Plugin 'tomtom/tcomment_vim'             " Makes it easier to comment files
Plugin 'ervandew/supertab'                  " Make completions easier
Plugin 'mattn/emmet-vim'                       " Emmet html for vim
"" Plugin 'Valloric/YouCompleteMe'          " C/C++/Objective-C/Python/C autocomplete
"Plugin 'w0rp/ale'                             "Asynchronous Linting machine
"Plugin 'pangloss/vim-javascript'               "Javascript Highlighting
"Plugin 'mxw/vim-jsx'                           " JSX Highlighting
"Plugin 'nathanaelkane/vim-indent-guides' " Shows indent lines
"" Plugin 'mattn/gist-vim'                  " Plugin for creating gist at gist.github.com
"" Plugin 'yuratomo/w3m.vim'               " Browser for vim
"Plugin 'rne1223/w3m.vim'                 " My forked of the Yuratomo's repository
"Plugin 'elzr/vim-json'                   " Json syntax highlight
"" Plugin 'chriskempson/vim-tomorrow-theme' " Tomorrow color theme
"" Plugin 'w0ng/vim-hybrid'                " vim-hybrid scheme
" Plugin 'davidhalter/jedi-vim'             " Python completer
"Plugin 'davidhalter/jedi-vim', {'commit': '1773837a11f311bd04755c70de363b5000c9cd15'}
"" Plugin 'digitaltoad/vim-pug'             " Syntax hightlight for pug
"" Plugin 'jmcantrell/vim-virtualenv'      " Python Virtual Enviroment Plugin
"Plugin 'skywind3000/asyncrun.vim'		" Quick compilation of programs without leaving vim
"" Plugin 'chrisbra/Colorizer'             "Show the colors being use in sass/css files
"Plugin 'bling/vim-airline'               " Makes a pretty status line
""Plugin 'jaredly/vim-debug'               " Python debugger
 
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on 

""===================
"" AsyncRun Plugin
""===================
" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>
function! s:compile_and_run()
  exec 'w'
  if &filetype == 'c'
    exec "AsyncRun! gcc % -o %<; time ./%<"
  elseif &filetype == 'cpp'
    exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
  elseif &filetype == 'java'
    exec "AsyncRun! javac %; time java %<"
  elseif &filetype == 'sh'
    exec "AsyncRun! time bash %"
  elseif &filetype == 'python'
    exec "AsyncRun! time python %"
  elseif &filetype == 'js'
    exec "AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %"
  endif
endfunction
" asyncrun now has an option for opening quickfix automatically
let g:asyncrun_open = 15
nmap <leader>d <Plug>(ale_fix)

""===================
"" Emmet Plugin Settings
""===================
" let g:user_emmet_leader_key='<Tab>'
" let g:user_emmet_mode='a' "enable all function in all modes
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

""===================
"" Ale Plugin
""===================
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_fix_on_save = 1
" let b:ale_linters = ['flake8','eslint']
let g:ale_fixers = {
\   'python': [
\       'remove_trailing_lines',
\       'isort',
\       'yapf',
\   ],
\   'javascript': ['eslint']
\}

nnoremap <buffer> <silent> <LocalLeader>= :ALEFix<CR>

""===================
"" Jedi Plugin
""===================
" let g:jedi#force_py_version = 3
autocmd FileType python setlocal omnifunc=jedi#completions

""===================
"" Completor Plugin
""===================
"" let g:completor_python_binary = '/usr/local/lib/python3.6/site-packages/jedi'
"
""===================
""w3m plugin settings
""===================
""let g:w3m"external_browser = 'chrome'
""let g:w3m"lang = 'en_US'
"
""===========================
""Colorizer plugin settings
""===========================
""let g:colorizer_auto_color = 1 

"Get rid of Python 3 Warnings
" https://github.com/vim/vim/issues/3117
if has('python3')
  silent! python3 1
endif
