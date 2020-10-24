" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif


call plug#begin('~/.config/nvim/autoload/plugged')

    " ========== Editing Plugins =========== "
    " Trailing whitespace highlighting & automatic fixing
    Plug 'ntpeters/vim-better-whitespace'

    " auto-close plugin
    Plug 'rstacruz/vim-closer'

    " Improved motion in Vim
    Plug 'easymotion/vim-easymotion'

    " Intellisense Engine
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc-python'

    " FZF - Fuzzy file finding, file management, project searching
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Snippet support
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'

    " Comment stuff out easily
    Plug 'tpope/vim-commentary'

    " The undo history visualizer for VIM
    Plug 'mbbill/undotree'


    Plug 'liuchengxu/vista.vim'

    " ========== Git Plugins ========== "
    " Enable git changes to be shown in sign column
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'

    " ========== Python ========== "
    " Plugin that modifies Vim’s indentation behavior to comply with PEP8
    Plug 'Vimjas/vim-python-pep8-indent'

    " ALE (Asynchronous Lint Engine) is a plugin providing linting
    Plug 'dense-analysis/ale'

    " ========== Debugger ========== "
    "Plug 'puremourning/vimspector'

    " ========== Javascript Plugins ========== "
    " Typescript syntax highlighting
    "Plug 'HerringtonDarkholme/yats.vim'

    " ReactJS JSX syntax highlighting
    "Plug 'mxw/vim-jsx'

    " Generate JSDoc commands based on function signature
    "Plug 'heavenshell/vim-jsdoc'


    " ==== Golang Plugins ========== "
    " Vim-Go
    "Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " ========== Syntax Highlighting ========== "
    " Syntax highlighting for nginx
    "Plug 'chr4/nginx.vim'

    " Syntax highlighting for javascript libraries
    "Plug 'othree/javascript-libraries-syntax.vim'

    " Improved syntax highlighting and indentation
    "Plug 'othree/yajs.vim'


    " ========== UI ========== "
    " File explorer
    Plug 'scrooloose/NERDTree'

    " Colorscheme
    Plug 'mhartington/oceanic-next'

    " Customized vim status line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Icons
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'


    " ========== Miscellaneous ========== "

    " VimWiki
    Plug 'vimwiki/vimwiki'

call plug#end()


