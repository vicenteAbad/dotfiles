call plug#begin()
Plug 'preservim/NERDTree'
Plug 'itchyny/lightline.vim'
Plug 'lrvick/Conque-Shell'
call plug#end()

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree when Vim is opened and leave the cursor in it.
autocmd VimEnter * NERDTree

" Start NERDTree when Vim is opened and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
			\ quit | endif


let g:activate = "0"
let g:wid = "0"
function ConqueTermSplitActivate()
    if g:activate == "0"
	ConqueTermSplit zsh
	resize 10
        let g:activate = "1"
        let g:wid = win_getid()
	echo "ConqueTermSplit activate"
    else
	call win_gotoid(g:wid)
	quit
        let g:activate = "0"	
	echo "ConqueTermSplit desactivate"
    endif
endfunction
nmap <C-s> :call ConqueTermSplitActivate() <CR>

set number
nmap <f2> :set number! number?<cr>
nmap <f3> :set relativenumber! relativenumber? <cr>
