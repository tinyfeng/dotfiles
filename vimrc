" ================ Vim only : start ==============
" Neovim has defaults
if !has("nvim")
set rubydll=/Users/lankr/.rvm/rubies/ruby-2.6.3/lib/libruby.2.6.dylib
let $RUBYHOME="/Users/lankr/.rvm/rubies/ruby-2.6.3"

  " Use Vim settings, rather then Vi settings (much better!).  " This must be first, because it changes other options as a side effect.
  set nocompatible

  set ttyfast
  set backspace=indent,eol,start  "Allow backspace in insert mode
  set history=10000               "Store lots of :cmdline history
  set autoread                    "Reload files changed outside vim
  set autoindent
  set visualbell                  "No sounds
  scriptencoding utf-8
  set encoding=utf-8
  set incsearch                   " Find the next match as we type the search
  set hlsearch                    " Highlight searches by default
  set smarttab
  set showcmd                     "Show incomplete cmds down the bottom set
  set sidescroll=1
  set tags=.tags;,tags
  set tabpagemax=50
  set listchars=tab:\>\ ,trail:-,nbsp:+ " Display tabs and trailing spaces visually
  set wildmenu                    "enable ctrl-n and ctrl-p to scroll thru matches
  set background=dark

" ================ Persistent Undo ==================
  " Keep undo history across sessions, by storing in file.
  " Only works all the time.
  if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
    set undofile
  endif

endif
" ================ Vim only : end   ==============


" make Vim 8 slow
" set lazyredraw

set smartindent

 " leave insert mode quickly
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=";"

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================
set number                      "Line numbers are good
set gcr=a:blinkon0              "Disable cursor blink

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" =============== Vim-Plug Initialization ===============
if filereadable(expand("~/.vim/plug.vim"))
  source ~/.vim/plug.vim
endif
au BufNewFile,BufRead *.vim set filetype=vim

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Indentation ======================

set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

vnoremap <leader>p "0p
vnoremap <leader>P "0P

"set nowrap       "Don't wrap lines
set wrap       "Default wrap
"let &colorcolumn=join(range(81,999),",")

set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc,.git,build/*,*.beam,ebin/*,*.class,*.lo,*.log,*coverage*,*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/node_modules/*
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15

" ================ Search ===========================

set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if has("termguicolors")
    " fix bug for vim
    "set t_8f=[38;2;%lu;%lu;%lum
    "set t_8b=[48;2;%lu;%lu;%lum
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    " enable true color
    set termguicolors
endif

" ================ Custom Settings ========================
let g:yadr_disable_solarized_enhancements = 1
let vimsettings = '~/.vim/settings'
for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  exe 'source' fpath
endfor

" ================ Coc Settings Begin ========================
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> KK :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>fs  <Plug>(coc-format-selected)
nmap <leader>fs  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>aa  <Plug>(coc-codeaction-selected)
nmap <leader>aa  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <c-m> <Plug>(coc-range-select)
" xmap <silent> <c-m> <Plug>(coc-range-select)
nnoremap <c-m> <TAB>
xnoremap <c-m> <TAB>
nnoremap <silent> <TAB> <Plug>(coc-range-select)
xnoremap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" ================ Coc Settings End ========================


" ================ Color scheme ========================

let g:enable_bold_font = 0
let g:enable_italic_font = 1

let g:hybrid_custom_term_colors = 0
let g:hybrid_reduced_contrast = 1
colorscheme solarized8
let g:lightline.colorscheme='solarized'

map <leader>ff <C-p>
" ;q 强制退出
map q :q<cr>
" ;w 保存
map <leader>w :w!<cr>
" ;W 保存并退出
map W :wq!<cr>
" ;Q 退出全部窗口
map Q :qa!<cr>
" ;e 保存只读文件
map <leader>e :w !sudo tee %<cr>
" ;tn 打开或关闭目录数
map <leader>tn :NERDTreeToggle<cr>

map <Leader>gb :Gblame<cr>
nnoremap <f2> $
nnoremap <f1> ^
inoremap <f2> <esc>$a
inoremap <f1> <esc>^i
vnoremap <f2> $<left>
vnoremap <f1> ^
set autoread
nnoremap ;' bi'<esc>ea'<esc>
autocmd TextChanged,TextChangedI <buffer> silent write
imap <c-h> <left>
imap <c-j> <down>
imap <c-k> <up>
imap <c-l> <right>
tnoremap <esc> <C-\><C-n>
nnoremap <C-j> 5j
nnoremap <C-k> 5k
vnoremap <C-j> 5j
vnoremap <C-k> 5k
noremap <leader>nrc :te<cr>:f rc<cr>a rails c <cr>
noremap <leader>nrc :te<cr>:f te<cr>
noremap <leader>nrs :te<cr>:f rs<cr>a rails s <cr>
noremap <leader>nsi :te<cr>:f si<cr>a bundle exec sidekiq -C config/sidekiq.yml <cr>
nnoremap <leader>brc :b rc<cr>
nnoremap <leader>bsi :b si<cr>
nnoremap <leader>brs :b rs<cr>
nnoremap <leader>bte :b te<cr>
nnoremap <leader>frc :f rc<cr>
nnoremap <leader>frs :f rs<cr>
nnoremap <leader>fte :f te<cr>
nnoremap <leader>fsi :f si<cr>

" 在换行的一行中上下移动
nnoremap j gj
nnoremap k gk
nnoremap <leader>te :te<cr><cr>
nnoremap <Leader>ac :Ag "<cword>" <cr>
nnoremap <leader>ag :Ag ""<Left>
nnoremap <leader>ff ,ff
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>h :vertical resize +10<CR>
nnoremap <leader>l :vertical resize -10<CR>
if exists("did_load_csvfiletype")
  finish
endif
let did_load_csvfiletype=1

augroup filetypedetect
  au! BufRead,BufNewFile *.csv,*.dat	setfiletype csv
augroup END
filetype plugin on
set rtp+=~/tabnine-vim
autocmd CursorHold,CursorHoldI * update
hi SpecialKey ctermbg=NONE guibg=NONE
if has("gui_macvim")
  nnoremap <leader>te :terminal<cr>
  " Press Ctrl-Tab to switch between open tabs (like browser tabs) to
  " the right side. Ctrl-Shift-Tab goes the other way.
  noremap <leader>l :tabnext<CR>
  noremap <leader>h :tabprev<CR>

  " Switch to specific tab numbers with Command-number
  noremap <D-1> :tabn 1<CR>
  noremap <D-2> :tabn 2<CR>
  noremap <D-3> :tabn 3<CR>
  noremap <D-4> :tabn 4<CR>
  noremap <D-5> :tabn 5<CR>
  noremap <D-6> :tabn 6<CR>
  noremap <D-7> :tabn 7<CR>
  noremap <D-8> :tabn 8<CR>
  noremap <D-9> :tabn 9<CR>
  " Command-0 goes to the last tab
  noremap <D-0> :tablast<CR>
endif
