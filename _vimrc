call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on
filetype on
filetype plugin on

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set nocompatible
" �رձ���
set nobackup
" �ڴ���δ�����ֻ���ļ���ʱ�򣬵���ȷ��
set confirm
" ���ļ����ⲿ�иĶ�ʱ���Զ�����
set autoread

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"encoding
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set encoding=prc

"��������
set langmenu=zh_CN.UTF-8
set helplang=cn

" ���ش���
set guioptions-=T
" ���ڴ�ʱ���
au GUIENTER * simalt ~x
" ��ʾ�к�
set number
set colorcolumn=81
" ������ʾ״̬��
set laststatus=2

" ����ƥ��ģʽ�����Ƶ�����һ��������ʱ��ƥ����Ӧ���Ǹ�������
set showmatch
" ������ʾ���ҽ��
set hlsearch
" ��������
set incsearch
" �滻ʱ,ʹ��g��ǩ��ΪĬ������. ���滻ʱ,�滻�������з��ϵ�ƥ��
set gdefault

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" �Զ�����
set autoindent
set cindent
set smartindent

" ͳһ����Ϊ4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autochdir

" Tab���Ŀ��
set expandtab
set smarttab

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

""""""""""""""""""""""""""""""
" => python
""""""""""""""""""""""""""""""
" ����Python�ű��ļ���ӳ��
map <F5> :!python.exe %

let g:pydoc_cmd = "Python c:/Python27/Lib/pydoc.py"
if has("autocmd")
	" ���������(.)ʱ,�Զ����������˵�
    autocmd FileType python imap <buffer> . .<C-X><C-O><C-P>
endif
" Pydiction
let g:pydiction_location = 'C:\Program Files\Vim\vim73\ftplugin\complete-dict'

""""""""""""""""""""""""""""""
" => space end of line
""""""""""""""""""""""""""""""
" remove space end of line
autocmd BufWritePre * :%s/\s\+$//e
" highlight space end of line
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

""""""""""""""""""""""""""""""
" => SuperTab
""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "context"

""""""""""""""""""""""""""""""
" => syntastic
""""""""""""""""""""""""""""""
let g:syntastic_check_on_open=1

""""""""""""""""""""""""""""""
" => TlistToggle plugin
""""""""""""""""""""""""""""""
let g:tagbar_ctags_bin='C:\Program Files (x86)\Vim\vimfiles\bundle\ctags58\ctags.exe'
:nmap <F9> :TagbarToggle<CR>

""""""""""""""""""""""""""""""
" => font
""""""""""""""""""""""""""""""
set background=dark
set guifont=Courier\ New:h12:cANSI
colorscheme jellybeans
