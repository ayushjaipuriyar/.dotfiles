set termguicolors
set showcmd
set showmatch
set ruler
set relativenumber
set formatoptions+=o
set textwidth=0
set expandtab
set tabstop=2
set shiftwidth=2
set noerrorbells
set modeline
set linespace=0
set nojoinspaces
set background=dark
set hidden
filetype plugin on
filetype indent on
" More Natural splits
set splitbelow
set splitright

set ignorecase
set smartcase
set gdefault
set magic

set smartindent
set autoindent
set completeopt -=preview
"Set system clipboard as default
set clipboard+=unnamedplus
""""""""""" Custom Keybindings
nnoremap <SPACE> <Nop>
let mapleader="\<SPACE>"
nnoremap <leader>e :e $MYVIMRC<CR>   "Edit vimrc
nnoremap <leader>s :source $MYVIMRC<cr>
"Better split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }
Plug 'bluz71/vim-moonfly-colors'
Plug 'neovim/nvim-lspconfig'
call plug#end()
colorscheme moonfly
let g:airline_powerline_fonts = 1

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
     \ quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Arrows for NERDtree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

lua << EOF
  require 'nvim-treesitter.install'.compilers = { "gcc" }
  local treesitter = require'nvim-treesitter.configs'
  treesitter.setup {
    ensure_installed = {"c", "cpp", "python", "html", "javascript", "lua", "json", "css"},
    highlight = {
      enable = true
    }
  }
  require'lspconfig'.pyright.setup{}
  require'lspconfig'.clangd.setup{
    cmd= {"clangd", "--background-index", "--log=verbose"}
  }
EOF
