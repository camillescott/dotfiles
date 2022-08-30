let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

" alignment foo
Plug 'godlygeek/tabular'

" fuzzy finding, browsing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vijaymarupudi/nvim-fzf'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'liuchengxu/vista.vim'
Plug 'itchyny/lightline.vim'

" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'} " color highlighting
Plug 'antoinemadec/coc-fzf'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" color highlight movement
Plug 'easymotion/vim-easymotion'

" color / pretty related
Plug 'vim-scripts/CycleColor'
Plug 'flazz/vim-colorschemes'
Plug 'jnurmine/Zenburn'
Plug 'franbach/miramare'
Plug 'arcticicestudio/nord-vim'
"Plug 'EdenEast/nightfox', {'commit': 'd83145614e8082b24a001643f1c6c00c0ea9aaef'}
Plug 'EdenEast/nightfox.nvim', { 'tag': 'v1.0.0' } 
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'

" documentation plugins
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'kkoomen/vim-doge'
"Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'alpertuna/vim-header'

" highlighting support
Plug 'sheerun/vim-polyglot'
Plug 'coyotebush/vim-pweave'
Plug 'ivan-krukov/vim-snakemake'
Plug 'tshirtman/vim-cython'
Plug 'plasticboy/vim-markdown'
Plug 'lepture/vim-jinja'

call plug#end()

" coc.nvim {{{
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-jedi', 'coc-yaml', 'coc-cmake']
" }}}
filetype plugin indent on    " required

" Make the leader comma
let mapleader=","

set nocompatible
set ttyfast
set lazyredraw
set signcolumn=yes
set showmatch

" Im a bad vimmer, gimme mouse
set mouse+=a
" set ttymouse=sgr

" Makes backspace work in insert mode on osx
set backspace=indent,eol,start

" turn on syntax highlighting
if has("syntax")
    syntax on
endif

set nowrap
set number

" NerdTree mapping
map <F2> :NERDTreeToggle<CR>

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
"let NERDTreeDirArrowExpandable="\u00a0"
"let NERDTreeDirArrowCollapsible="\u00a0"
let g:webdevicons_conceal_nerdtree_brackets = 1

let g:rainbow_active = 1
let g:rainbow_conf = {
  \    'separately': {
  \       'nerdtree': 0
  \    }
  \}

" vim-markdown options
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1

" vim-polyglot conceal
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" vim headers
let g:header_auto_add_header = 0
let g:header_field_author = 'Camille Scott'
let g:header_field_author_email = 'camille.scott.w@gmail.com'
let g:header_field_copyright = '(c) Camille Scott, 2021'
let g:header_field_modified_by = 0
let g:header_field_modified_timestamp = 0
let g:header_field_license_id = 'MIT'

let orgfoldexpr=&foldexpr

" vim-doge doc generation
let g:doge_doc_standard_python = 'google'
let g:doge_python_settings = {'single_quotes': 1}

" fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

let g:vista_default_executive = 'coc'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]


" filetype stuff
autocmd FileType markdown setlocal spell|setlocal textwidth=100
autocmd FileType markdown set tabstop=4|set shiftwidth=4|set expandtab|set linebreak|set wrap

augroup rmd_ft
    au!
    autocmd BufNewFile,BufRead *.Rmd set syntax=markdown|set linebreak|set wrap|set spell
augroup END

au BufRead,BufNewFile *.rst setlocal textwidth=100
autocmd FileType rst setlocal spell
au BufRead,BufNewFile *.tex setlocal textwidth=100
autocmd FileType tex setlocal spell
au BufRead,BufNewFile *.texw setlocal textwidth=100
autocmd FileType Pweave setlocal spell

augroup snakefile_ft
  au!
  autocmd BufNewFile,BufRead *.snakefile set syntax=snakemake|set tabstop=4|set shiftwidth=4|set expandtab|set
augroup END

"""
"
" CoC config
"
""""

set hidden

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
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction-line)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"augroup vimrc
"   autocmd!
"   autocmd ColorScheme * highlight Normal ctermbg=NONE guifg=black guibg=NONE
"   autocmd ColorScheme * highlight MatchParen cterm=bold ctermfg=yellow ctermbg=brown gui=bold guifg=red guibg=NONE
"augroup END

nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"set t_Co=256
"if &term =~ '256color' | set t_ut= | endif " Disable Background Color Erase (tmux)
set termguicolors
set conceallevel=3

let g:lightline = {
      \ 'colorscheme': 'nightfox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified', 'method' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'method': 'NearestMethodOrFunction',
      \   'cocstatus': 'StatusDiagnostic'
      \ },
      \ }


"let g:camillionaire_transparent_background = 1
"colorscheme camillionaire
colorscheme nordfox

" nightfox/nordfox is configured in lua...
lua << EOF
local nightfox = require('nightfox')
nightfox.setup({
    fox = "nordfox",
    transparent = true,
    styles = {
        comments = "italic", -- change style of comments to be italic
        strings = "italic",
    },
})
nightfox.load()
EOF

set cursorline
set fillchars+=vert:\║
