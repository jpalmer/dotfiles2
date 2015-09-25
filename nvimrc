" vim:fdm=marker
"  Plugins {{{
call plug#begin('~/.nvim/plugged')
"Plug 'chriskempson/base16-vim'          "colours
Plug 'majutsushi/tagbar'                "for a C program shows the functions / definitions in a bar
Plug 'kien/ctrlp.vim'                   "better way to open files
Plug 'godlygeek/tabular'                "align stuff
Plug 'bruno-/vim-man'                   "view manpages
Plug 'bronson/vim-trailing-whitespace'  "tidy up whitespace
Plug 'vim-scripts/a.vim'                "switch .h / .c
Plug 'tpope/vim-commentary'             "easy comment lines
Plug 'tpope/vim-sensible'               "sets a bunch of defaults
Plug 'bling/vim-airline'                "Powerline like behaviour from nvim
Plug 'weynhamz/vim-plugin-minibufexpl'  "show open files at top of window
Plug 'vim-scripts/restore_view.vim'     "save/ restore view - incl position in file
"Plug 'nathanaelkane/vim-indent-guides'  "show indent with color
Plug 'kien/rainbow_parentheses.vim'     "rainbow coloured brackets to show matching
Plug 'morhetz/gruvbox'                  "new color scheme
Plug 'Yggdroot/indentLine'
Plug 'junegunn/goyo.vim'
"Plug 'Valloric/YouCompleteMe', {'do' : ' ./install.sh --clang-completer --system-libclang'}            "semantic completion
call plug#end()
" }}}
" basic vim config {{{
set ignorecase                          "better searching - ignore case
set smartcase                           "better searching - be case sensitive when caps used
set mouse=a                             "enable mouse in all modes
set clipboard+=unnamedplus              "use the system clipboard properly
set nocompatible                        "Vim defaults instead of Vi
set number                              "line numbering on
set autowrite                           "save before make
set showmatch                           "show matching brackets
set visualbell                          "visual bell
set tabstop=4                           "tabs have correct size
set shiftwidth=4                        "more tab stuff
set expandtab                           "convert tabs to spaces
set colorcolumn=80                      "have a column with colors at 80 to show long lines
"folds This setup makes the folds sensitive to indenting
au BufReadPre * setlocal foldmethod=indent
"}}}
"Remap keys {{{
"Can't put comments on the same line here
"sometimes we miss shift
nnoremap ; :
"disable arrows in normal mode
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"move in screen lines
nnoremap j gj
nnoremap k gk
nnoremap <tab> %
nnoremap <space> za
"}}}
"Keys for navigating splits - make it use ctrl+hjkl {{{
:nmap <silent> <C-h> <C-W><C-h>
:nmap <silent> <C-j> <C-W><C-j>
:nmap <silent> <C-k> <C-W><C-k>
:nmap <silent> <C-l> <C-W><C-l>
"}}}
"Quckfix window {{{
autocmd QuickFixCmdPost [^l]* nested cwindow    "open quickfix window on make
autocmd QuickFixCmdPost    l* nested lwindow
"make! doesn't jump to the first error - better default
cabbrev make make!
"}}}
"airline config {{{
let g:airline_powerline_fonts=1         "use powerline fonts in airline
" }}}
"colorscheme {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 "full color
"let base16colorspace=256                "have 256 colors
set background=light
colorscheme gruvbox            "pick colorscheme
if &diff                                "the default vim colorscheme is much better for diff mode - could maybe change this though
 "   colorscheme default
endif
"}}}
"minibufexpl {{{
let g:miniBufExplUseSingleClick=1       "minibufexpl uses single click
"}}}
"Tagbar {{{
nmap <F8> :TagbarToggle<CR>
"}}}
"GUI options {{{
set guioptions-=L       "hide scroll bar
set guioptions-=r
"}}}
"Rainbow parentheses options {{{
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"}}}
"indent guides parameters {{{
let g:indent_guides_auto_colors = 0
let g_gruvbox_invert_indent_guides = 1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=white   ctermbg=white
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgrey ctermbg=lightgrey
"au VimEnter * IndentGuidesEnable
"}}}
"youcompleteme options {{{
let g:ycm_extra_conf_globlist = ['*/spikegrid/*']
let g:ycm_key_invoke_completion= '<Tab>' "use tab for completion
"}}}
"ignore files for completion {{{
set wildignore+=*/jobtest/*,jobtest
let g:ctrlp_custom_ignore = {
            \ 'dir':'\v[\/]\.(jobtest)$',
            \}
"}}}
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 "change cursor shape in different modes


set conceallevel=0 "some files are having this changed - very bad
let g:indentLine_fileTypeExclude= ['tex', 'latex']
