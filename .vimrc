:let mapleader = ",,"
:let maplocalleader = '.,'

:syntax enable
:inoremap jk <Esc>
:vnoremap jk <Esc>
:tmap <Esc> <C-\><C-n>
:set number 
:set relativenumber
:set autoindent
:set tabstop=2
:set softtabstop=2
:set shiftwidth=2
:set expandtab
:set cursorline
:set scrolloff=8
:set clipboard+=unnamedplus
:set mouse=a

" ignore node_modules when using grep
:set wildignore+=*/node_modules/*

:set exrc "override with a local .nvimrc
:filetype on
:filetype plugin on
:filetype indent on

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <c-l> <c-w>l
:nnoremap o o<esc>
:nnoremap O O<esc>
:nnoremap <C-t> :NERDTreeToggle<CR>
" source .vimrc
:nnoremap <leader>sv :source $MYVIMRC<cr>



" PlugInstall
call plug#begin('~/.vim/plugged')
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
  Plug 'alvan/vim-closetag'
  Plug 'https://codeberg.org/esensar/nvim-dev-container'
  Plug 'cocopon/iceberg.vim'
  Plug 'cormacrelf/vim-colors-github'
  " Plug 'neoclide/vim-jsx-improve'
  Plug 'ctrlpvim/ctrlp.vim'
  "Plug 'dracula/vim',{'name':'dracula'}
  Plug 'jiangmiao/auto-pairs'
  Plug 'kamykn/popup-menu.nvim'
  Plug 'kamykn/spelunker.vim'
 Plug 'maxmellon/vim-jsx-pretty'
  Plug 'neoclide/coc.nvim', {'branch':'release'} 
  Plug 'sonph/onehalf', {'rtp': 'vim'}
 Plug 'pangloss/vim-javascript' 
  Plug 'preservim/nerdtree'
  Plug 'prettier/vim-prettier'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  " Plug 'tpope/vim-sleuth' " sets tab withs
  Plug 'vim-airline/vim-airline'
 " Plug 'ruanyl/vim-sort-imports'
  Plug 'SirVer/ultisnips' " snipits
  Plug 'lervag/vimtex'
  Plug 'vimwiki/vimwiki'
  Plug 'nvim-lua/plenary.nvim' " telescope dependency
  Plug 'BurntSushi/ripgrep' " recursive fuzzy finder that follows .gitignore rules
  Plug 'nvim-telescope/telescope.nvim' 
  Plug 'nvim-telescope/telescope-media-files.nvim'
  Plug 'nvim-lua/popup.nvim'
  "Plug 'edluffy/hologram.nvim' " kitty terminal image viewer
  """Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  " Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'} " vim keybindings to navigate between vim and kitty windows
  Plug 'fladson/vim-kitty' " syntax hilighting for .conf files
  Plug 'pantharshit00/vim-prisma'
 Plug 'rust-lang/rust.vim'
call plug#end()

" Nerdtree Settings

" handle formating for large jsx files
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear


let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
" this was preventing auto format if there is not a config, mostly i don't
" need config:
"let g:prettier#autoformat_config_present = 1 
"
"Plugin Settings ---------------------------------------------{{{
" spelunker settings 
let g:spelunker_disable_uri_checking = 1
let g:spelunker_disable_email_checking = 1
" closetag
let g:closetag_filenames = '*.html,*.jsx'

" " ultisnips settings
" let g:UltiSnipsExpandTrigger  = '<Tab>'
" let g:UltiSnipsJumpForwardTrigger = '<Tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>' "Shift tab
"}}}
"
" Rust 
let g:rustfmt_autosave = 1


:colo iceberg
:command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')


" coc Specific settings
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
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
" command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
" and then write the file
 command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport') 
 nnoremap <leader>or :OR<CR>
" format on save
"autocmd BufWritePre *.jsx :silent call CocAction('runCommand', 'editor.action.organizeImport') " this creates issues with eslint

" " Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" VimTex Config
let g:vimtex_view_method = 'zathura'



""" Telescope """
lua << EOF
require('telescope').setup {
  defaults = {
  mappings = {
      i = {
        ["C-h>"] = "which_key"
      }
    },
  preview_cutoff =1,
  set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

  },
  pickers = {},
  extensions = {
  --  fzf = {
  --    fuzzy = true,
  --    override_generic_sorter = true,
  --    override_file_sorter = true,
  --    case_mode = "smart_case",
  --    },
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg"
      }
    }
}
-- require('telescope').load_extension('fzf')
 require('telescope').load_extension('media_files')
-- docker nvim-dev-container
require("devcontainer").setup{}
EOF

:nnoremap <leader>ff :Telescope find_files<CR>
:nnoremap <leader>lg :Telescope live_grep<CR>
:nnoremap <leader>fm :Telescope media_files<CR>
