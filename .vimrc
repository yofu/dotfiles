""" SETTING
set nocompatible
set nowrap
set number
if has('gui')
    set guifont=Takaoゴシック:h12:cSHIFTJIS
    " set guifont=SourceSansPro-Light:h8:cSHIFTJIS
    set guioptions-=m
    set guioptions-=T
    set guioptions+=b
endif
set backupdir=C:\vim73-kaoriya-win32\backup
set directory=C:\vim73-kaoriya-win32\backup
set shiftwidth=4
set tabstop=4
set expandtab
set grepprg=jvgrep
set nrformats=
" set nrformats=octal,hex

"" print options
set printoptions=wrap:y,number:n,left:25mm,right:25mm,top:25mm,bottom:25mm
set printfont=MS_Mincho:h8:cSHIFTJIS
set printheader=%F\ %{strftime('%Y-%m-%d\ %H:%M')}

""" MAPPING
noremap ; :
noremap : ;

"" カーソル下のファイルをタブで開く
nnoremap gf <C-W>gf
nnoremap <C-W>gf gf

"" Insert Modeでカーソル移動
"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"inoremap <C-h> <Left>
"inoremap <C-l> <Right>

"" Visual Modeで選択したテキストを*で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

"" 空行を挿入
nnoremap <Space>0 :<C-u>call append(expand('.'), '')<Cr>j

"" Visual Modeで繰返しインデント
vnoremap < <gv
vnoremap > >gv

""help
nnoremap <C-h> :<C-u>h<Space>

""regexp:
" \v->very magic
" \m->magic
" \M->nomagic
" \V->very nomagic
nnoremap / /\v

"" split: Hack # 159
nmap <Space>sj <SID>(split-to-j)
nmap <Space>sk <SID>(split-to-k)
nmap <Space>sh <SID>(split-to-h)
nmap <Space>sl <SID>(split-to-l)

nnoremap <SID>(split-to-j) :<C-u>execute 'belowright' (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <SID>(split-to-k) :<C-u>execute 'aboveleft'  (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <SID>(split-to-h) :<C-u>execute 'topleft'    (v:count == 0 ? '' : v:count) 'vsplit'<CR>
nnoremap <SID>(split-to-l) :<C-u>execute 'botright'   (v:count == 0 ? '' : v:count) 'vsplit'<CR>

""" Command-line window: Hack #161
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>

nmap : <SID>(command-line-enter)
xmap : <SID>(command-line-enter)

autocmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
    nnoremap <buffer> q :<C-u>quit<CR>
    nnoremap <buffer> <Tab> :<C-u>quit<CR>
    inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
    inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
    inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"

    " Completion
    inoremap <buffer><expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

    startinsert!
endfunction

"" virtualedit
set virtualedit=all
if has('virtualedit') && &virtualedit =~# '\<all\>'
    nnoremap <expr> p (col('.') >=col('$') ? '$' : '') . 'p'
endif

"" sticky shift
inoremap <expr> ; <SID>sticky_func()
cnoremap <expr> ; <SID>sticky_func()
snoremap <expr> ; <SID>sticky_func()

function! s:sticky_func()
    let l:sticky_table = {
                \',' : '<', '.' : '>', '/' : '?',
                \'1' : '!', '2' : '@', '3' : '#', '4' : '$', '5' : '%',
                \'6' : '^', '7' : '&', '8' : '*', '9' : '(', '0' : ')', '-' : '_', '=' : '+',
                \';' : ':', '[' : '{', ']' : '}', '`' : '~', "'" : "\"", '\' : '|',
                \}
    let l:special_table = {
                \"\<ESC>" : "\<ESC>", "\<Space>" : ';', "\<CR>" : ";\<CR>"
                \}
    let l:key = getchar()
    if nr2char(l:key) =~ '\l'
        return toupper(nr2char(l:key))
    elseif has_key(l:sticky_table,nr2char(l:key))
        return l:sticky_table[nr2char(l:key)]
    elseif has_key(l:special_table,nr2char(l:key))
        return l:special_table[nr2char(l:key)]
    else
        return ''
    endif
endfunction

"" :Rename
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

filetype plugin indent off

""" PLUG IN
"" NeoBundle
if has ('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
	call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet.git'

NeoBundle 'ujihisa/neco-rubymf'

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'

NeoBundle 'tomtom/tcomment_vim'

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-lastpat'
NeoBundle 'rhysd/vim-textobj-ruby'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-scouter'

NeoBundle 'tyru/vim-altercmd'

NeoBundle 'kchmck/vim-coffee-script'

NeoBundle 'JuliaLang/julia-vim'

NeoBundle 'vim-scripts/VimClojure'

NeoBundle 't9md/vim-textmanip'

" NeoBundle 'kien/ctrlp.vim'

filetype plugin indent on

"" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
" inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <C-n> :NeoComplCacheToggle<CR>

""neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

imap <expr><Tab> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<Tab>"
smap <expr><Tab> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

"" textmanip
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

xmap <M-d> <Plug>(textmanip-duplicate-down)
nmap <M-d> <Plug>(textmanip-duplicate-down)
xmap <M-D> <Plug>(textmanip-duplicate-up)
nmap <M-D> <Plug>(textmanip-duplicate-up)

"" tcomment_vim
let g:tcommentBlankLines = 0

"" vimclojure
" let vimclojure#WantNailgun = 1
let vimclojure#HighlightBuiltins = 1
let vimclojure#ParenRainbow = 1
let vimclojure#DynamicHighlighting =1
" let vimclojure#NailgunClient = "ng"


""" AUTO
au BufNewFile,BufRead *.clj set filetype=clojure

au GUIEnter * simalt ~x

augroup fig2file
    autocmd!
    autocmd Bufread,BufNewFile *.fig2 setlocal filetype=fig2 
augroup END

augroup gofile
    autocmd!
    autocmd Bufread,BufNewFile *.go setlocal filetype=go 
augroup END

augroup coffee
    autocmd!
    autocmd Bufread,BufNewFile *.coffee setlocal filetype=coffee
augroup END

augroup julia
    autocmd!
    autocmd Bufread,BufNewFile *.jl setlocal filetype=julia
augroup END

let g:quickrun_config = {
            \ 'go': {
            \   'command': '8g',
            \   'exec': ['8g %s', '8l -o %s:p:r.exe %s:p:r.8', '%s:p:r.exe%a', 'rm -f %s:p:r.exe']
            \ }
            \}

augroup rust
    autocmd!
    autocmd Bufread,BufNewFile *.rs setlocal filetype=rust
augroup END

" augroup grepopen
"     autocmd!
"     autocmd QuickfixCmdPost vimgrep cw
" augroup END

" golang
set rtp+=$GOROOT/misc/vim
set rtp+=~/.vim
syntax on
