" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hlsearch

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END


  " [plugin]commentary config
  autocmd FileType lua set commentstring=--\ %s

  "[plugin]Fugitive
  autocmd User fugitive 
              \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
              \   nnoremap <buffer> .. :edit %:h<CR> |
              \ endif
  autocmd BufReadPost fugitive://* set bufhidden=delete
else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set rtp+=~/.vim/bundle/

set number

set tabstop=4
set shiftwidth=4

" except '_' from word
" set iskeyword=@,48-57,128-167,224-235

"set encoding
set fileencoding=utf-8
set encoding=utf-8
lang messages zh_CN.UTF-8 "解决console输入乱码
set termencoding=utf-8
set fileencodings=utf-8,cp936,ucs-bom,shift-jis,latin1,big5,gb18030,gbk,gb2312

source $VIMRUNTIME/delmenu.vim
set guifont=Monaco:h14
set guifontwide=华文宋体:h12

"remove scratch preview window
set completeopt-=preview

"set list char
set listchars=tab:■■,trail:▓,eol:▼

"set large file size
let g:LargeFile=10

" "set swap files directory
" set directory=$TEMP

" "set backup files directory
" set backupdir=$TEMP

"map , to copy and pase
nnoremap <silent> , "0
vnoremap <silent> , "0
nnoremap <silent> _ ,
vnoremap <silent> _ ,
nnoremap <silent> <Leader>p "*p
vnoremap <silent> <Leader>p "*p
nnoremap <silent> <Leader>y "*y
vnoremap <silent> <Leader>y "*y
nnoremap <silent> <Leader>P "*P
vnoremap <silent> <Leader>P "*P
nnoremap <silent> <Leader>Y "*Y
vnoremap <silent> <Leader>Y "*Y

" "Use system clipboard default
" set clipboard=unnamed


"map F5 to use ctags
nnoremap <silent> <F5> :silent !ctags -R .<CR>

"map F9 to create a new tab and open currentfile and mirror NERDTREE
nnoremap <silent> <F9> :tabe %<CR>:NERDTreeFind<CR><C-W>l:copen<CR><C-W>k

"map F10 to open current file's folder
nnoremap <silent> <F10> :!open .<CR><CR>
vnoremap <silent> <F10> :!open .<CR><CR>

"map [t and ]t: jump to parent tag
nnoremap ]t vatatv
nnoremap [t vatatov

"map vP to select changed area.
nnoremap <silent> vP `[v`]

"map for command mode
cnoremap <F1> <C-R>=escape()<Left>
cnoremap <F2> <C-R>=expand("")<Left><Left>

"set syntax rules for glsl and hlsl
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.fsh,*.vsh setf glsl
au BufNewFile,BufRead *.hlsl,*.fx,*.fxh,*.vsh,*.psh setf fx


" [plugin]pathogen config
" let g:pathogen_disabled = []
" call add(g:pathogen_disabled, 'some_thing_name')
execute pathogen#infect()

" [plugin]solarized config
syntax enable
set background=dark
colorscheme eva-unit-02
" other colorscheme: sonofobsidian/dracula/Tomorrow/vividchalk

"[plugin]tagbar config
nnoremap <silent> <F4> :TagbarOpen fj<CR>
nnoremap <silent> <S-F4> :TagbarClose<CR>

"[plugin]ctags config
set autochdir

"[plugin]Nerdtree
let NERDTreeShowBookmarks=1
let NERDMenuMode=1
let NERDTreeChDirMode=1

"[plugin]Fugitive
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"shortcut
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>:<C-u>MarkClear<CR><C-l>
nnoremap <silent> <C-k> :<C-u>Mark<CR>

" search and hightlight, but not move the next matching
nnoremap * *N

" In visual mode, map* and # to search current selected.
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>N
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
	let temp = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
	let @s = temp
endfunction

"map & to :&&. means reapeat the last :substitute command with flags.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"map g[ or g] to like [{ and ]}
nnoremap <silent> g[ :<C-u>call searchpair('\[', '', '\]', 'bW' )<CR>
xnoremap <silent> g[ :<C-u>call searchpair('\[', '', '\]', 'bW' )<CR>
nnoremap <silent> g] :<C-u>call searchpair('\[', '', '\]', 'W' )<CR>
xnoremap <silent> g] :<C-u>call searchpair('\[', '', '\]', 'W' )<CR>

"[plugin]neocomplcache installation
let g:neocomplcache_enable_at_startup = 1

"[plugin]clang_complete
let g:clang_complete_copen=1
let g:clang_periodic_quickfix=1
let g:clang_snippets=1
let g:clang_close_preview=1
let g:clang_use_library=1
let g:clang_library_path="D:\\Program\ Files\ (x86)\\LLVM\\bin"
let g:clang_user_options='-stdlib=libc++ -std=c++11 -IIncludePath'

"[plugin]SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabNoCompleteAfter = ['^', '\s', ',', '=']

"[plugin]Tabular
" let g:tabular_loaded = 0

"[plugin]EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-s)
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s)
omap z <Plug>(easymotion-s2)

let g:EasyMotion_smartcase = 1
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>j <Plug>(easymotion-j)
map <Leader>w <Plug>(easymotion-w)
map <Leader>W <Plug>(easymotion-W)
map <Leader>b <Plug>(easymotion-b)
map <Leader>B <Plug>(easymotion-B)
map <Leader>e <Plug>(easymotion-e)
map <Leader>E <Plug>(easymotion-E)
map <Leader>ge <Plug>(easymotion-ge)
map <Leader>gE <Plug>(easymotion-gE)

"[plugin]Auto-paris
let g:AutoPairsShortcutFastWrap='<M-m>'
" let g:AutoPairsMapSpace=0

"[plugin]ag
let g:aghighlight=1

"[plugin]mark
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev

"[tool]grep for windows
set grepprg=grep\ -n\ -r\ $*\ *
" set grepprg=ag\ --column

" [plugin]ag
let g:ag_apply_qmappings=0
let g:ag_apply_lmappings=0
let g:aghighlight=1

" map quick fix window.
function! s:MapQuickFixWindow()
	botright copen
	nnoremap <silent> <buffer> h  <C-W><CR><C-w>K
	nnoremap <silent> <buffer> H  <C-W><CR><C-w>K<C-w>b
	nnoremap <silent> <buffer> o  <CR>
	nnoremap <silent> <buffer> t  <C-w><CR><C-w>T
	nnoremap <silent> <buffer> T  <C-w><CR><C-w>TgT<C-W><C-W>
	" nnoremap <silent> <buffer> v  <C-w><CR><C-w>H<C-W>b<C-W>J<C-W>t

	nnoremap <silent> <buffer> e <CR><C-w><C-w>:cclose<CR>'
	nnoremap <silent> <buffer> go <CR>:copen<CR>
	nnoremap <silent> <buffer> q  :cclose<CR>
	nnoremap <silent> <buffer> gv :let b:height=winheight(0)<CR><C-w><CR><C-w>H:copen<CR><C-w>J:exe printf(":normal %d\<lt>c-w>_", b:height)<CR>
endfunc
" call <SID>MapQuickFixWindow()
command! -nargs=0 Copen call <SID>MapQuickFixWindow()


" [plugin]SalProj
let g:salproj_awake = 1


" map F3 to search selected
function! s:EscapeForSearch()
	if @" != "" 
		let @/ = '"' . escape(@", '/\ "%') . '"'
	else
		if @/ == ""
			let @/ = "!!!something_for_nothing!!!"
		endif
	endif
endfunction
function! s:EscapeForSearchVisual()
	let temp = @s
	norm! gv"sy

	" let hasSpace = stridx(@", " ")
	let @/ = '"' . escape(@s, '/\ "%') . '"'
	let @/ = substitute( @/, '\n', '\\n', 'g' )

	let @s = temp
endfunction
nnoremap <F3> :<C-u>call <SID>EscapeForSearch()<CR>:silent grep! <C-R>=@/<CR><CR>
xnoremap <F3> :<C-u>call <SID>EscapeForSearchVisual()<CR>:silent grep! <C-R>=@/<CR><CR>

" map F2 to search selected in current file
nnoremap <F2> :vim //j %<CR>
xnoremap <F2> :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>N:vim /<C-R>=@/<CR>/j %<CR>

" map ctrl-r + register not auto-indent in insert mode
inoremap <C-R> <C-R><C-O>

nnoremap <silent> <Leader>cp :let @*=expand("%")<CR>
nnoremap <silent> <Leader>cfp :let @*=expand("%:p")<CR>


" ***REGEX***
" 1. Zero width assertions
                           " Request   |       '/'command      |         "grep" command         |       "Grep" command
" --------------------------------------------------------------------------------------------------------------------------
    " match "Windows" in "WindowsXP"   |    /\vWindows(XP)@=   |    grep! -P Windows^(?=XP^)    |    Grep -P Windows(?=XP)
         " match "XP" in "WindowsXP"   |   /\v(Windows)@<=XP   |   grep! -P ^(?^<=Windows^)XP   |   Grep -P (?<=Windows)XP
" match "Windows" except "WindowsXP"   |    /\vWindows(XP)@!   |    grep! -P Windows^(?!XP^)    |    Grep -P Windows(?!XP)
         " match "XP" in "WindowsXP"   |   /\v(Windows)@<!XP   |   grep! -P ^(?^<!Windows^)XP   |   Grep -P (?<!Windows)XP
"
" 2. Custom command "Grep" is escape some character for windows cmdc.exe. If command "grep" not work, try it.

" Hex mode start.==========
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>
" Hex mode end.==========

" Copy matches to register.
" Search for a pattern, then enter :CopyMatches to copy all matches to the clipboard, or :CopyMatches x where x is any register to hold the result.
function! CopyMatches(reg) range
  let hits = []
  execute a:firstline.",".a:lastline.'s//\=len(add(hits, submatch(0))) ? submatch(0) : ""/ge'

  let reg = empty(a:reg) ? '+' : a:reg
  " clear register
  execute 'let @'.tolower(reg).' = ""'
  " copy matches to reigster
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
  
  " cancle the %s changes.
  normal u
  " Back to the position before
  exec "normal 2\<C-O>"
endfunction
command! -range=% -register CopyMatches call CopyMatches(<q-reg>)
command! -range=% -register CM <line1>,<line2> call CopyMatches(<q-reg>)
