set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"nerdtree
Plugin 'nerdtree' 

" nerdtree-git
Plugin 'nerdtree-git-plugin'

" vim-autoclose
Plugin 'vim-autoclose'

" ack.vim
Plugin 'ack.vim'

" vim-easytags
Plugin 'vim-easytags'

" vim-misc
Plugin 'vim-misc'

" tagbar
" Plugin 'tagbar'

" nerdcommenter
Plugin 'nerdcommenter'

" vim-surround
Plugin 'vim-surround'

" vim-eunuch
Plugin 'vim-eunuch'

" vim-endwise
Plugin 'vim-endwise'

" xmledit
Plugin 'xmledit'

" vim-easymotion
Plugin 'vim-easymotion'

" vim-repeat
Plugin 'vim-repeat'

Plugin 'incsearch.vim'
Plugin 'incsearch-easymotion.vim'
Plugin 'incsearch-fuzzy.vim'
Plugin 'deoplete.vim'
Plugin 'neosnippet.vim'
Plugin 'syntastic'
Plugin 'vim-php-cs-fixer'
Plugin 'phpcomplete.vim'
Plugin 'php.vim'
Plugin 'neocomplete.vim'
Plugin 'PHP-Indenting-for-VIm'
Plugin 'PDV--phpDocumentor-for-Vim'
Plugin 'vim-javascript'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""                     vim-easymotion config			      """"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)


"""" Use deoplete plugin
let g:deoplete#enable_at_startup = 1



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""                        php-cs-fixer config                     """"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If php-cs-fixer is in $PATH, you don't need to define line below
let g:php_cs_fixer_path = "~/softwares/php-cs-fixer-v2.phar" " define the path to the php-cs-fixer.phar

" If you use php-cs-fixer version 2.x
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
"let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
"let g:php_cs_fixer_config_file = '.php_cs' " options: --config
" End of php-cs-fixer version 2 config params

let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
