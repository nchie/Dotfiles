" oni specifics
set nocompatible
filetype off
set hidden

set number
set noswapfile
set smartcase

" If using Oni's externalized statusline, hide vim's native statusline,
" set noshowmode
" set noruler
" set laststatus=0
" set noshowcmd

" General
set mouse=a
set colorcolumn=80
set nowrap
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set splitbelow
set splitright
set cursorline

" Line numbers
set number
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Vim-Plug
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
" Session handling
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
" Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
" Themes
Plug 'tomasiser/vim-code-dark'
if has("win32")
	Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'powershell -executionpolicy bypass -File install.ps1' }
else
	Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
endif
call plug#end()

" Theme
colorscheme codedark
" set background=dark
set guifont=Menlo:h12
syntax on

let g:airline#extensions#tabline#enabled = 1
let g:SuperTabDefaultCompletionType = "context"

" Language Client
let g:LanguageClient_serverCommands = {
     \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
     \ }

let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_diagnosticsDisplay = {
    \1: { "signText": "💣" },
    \2: { "signText": "🚩" }
\}

" Deoplete
let g:deoplete#enable_at_startup = 1
" set completeopt-=preview
autocmd CompleteDone * pclose!
call deoplete#custom#option('sources', {
    \ 'rust': ['LanguageClient'],
\})


" ALE
" let g:ale_sign_error = '💣'
" let g:ale_sign_warning = '🚩'
" let g:ale_statusline_format = ['💣 %d', '🚩 %d', '']
" let g:ale_set_highlights = 1
" let g:ale_set_signs = 1
highlight ALEError ctermfg=red cterm=undercurl,bold guifg=red
highlight ALEWarning ctermfg=yellow cterm=undercurl,bold guifg=yellow

" Simple custom commands
command! TrimSpaces :%s/\s\+$//

" Mappings
let mapleader=" "

" Window switching
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l


noremap <C-n> :nohl<CR>
noremap Y y$
inoremap jj <Esc>
noremap <C-b> :ls<CR>:b<space>

" Indentation using tab
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" noremap <Leader>bd :ls<CR>:bd<space>
" noremap <Leader>bb :ls<CR>:b<space>

" Plugin mappings
noremap <Leader>f :NERDTreeToggle<CR>
noremap <Leader>t :TagbarToggle<CR>
noremap <Leader>c :ls<CR>:bd<space>
noremap <Leader>e :Ex<CR>
noremap <C-f> :GFiles<CR>

" Edit/reload vimrc
noremap <Leader>ie :edit $MYVIMRC<CR>
noremap <Leader>ir :source $MYVIMRC<CR>

" IDE-like bindings
noremap <Leader>h :call LanguageClient_textDocument_hover()<CR>
noremap <Leader>d :call LanguageClient_textDocument_definition()<CR>
noremap <Leader>r :call LanguageClient_textDocument_rename()<CR>
noremap <Leader>s :call LanugageClient_textDocument_documentSymbol()<CR>

