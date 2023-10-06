-- REMAPS
-- Leader
vim.g.mapleader = ','
vim.g.maplocalleader = "\\"

vim.cmd('imap jj <Esc>')

--" Disable arrows like a mofo
vim.cmd('inoremap <Up> <nop>')
vim.cmd('inoremap <Down> <nop>')
vim.cmd('inoremap <Left> <nop>')
vim.cmd('inoremap <Right> <nop>')
vim.cmd('nnoremap <Up> <nop>')
vim.cmd('nnoremap <Down> <nop>')
vim.cmd('nnoremap <Left> <nop>')
vim.cmd('nnoremap <Right> <nop>')

-- Edit common files
vim.cmd('nnoremap <leader>ev :sp $MYVIMRC<cr>')
vim.cmd('nnoremap <leader>ep :sp <C-R>=expand($VIRTUAL_ENV)."/bin/postactivate"<CR><CR>')

--" toggle case
vim.cmd('noremap <Leader>tl <esc>viwu')
vim.cmd('noremap <Leader>tu <esc>viwU')

--" move up|down in wrapped lines
vim.cmd('nnoremap j gj')
vim.cmd('nnoremap k gk')

vim.cmd('nnoremap <C-X> :bd!<CR>')
-- Make current buffer only buffer in split modes
vim.cmd('nnoremap <Leader>o <C-w><C-o>')
-- Undo buffer
vim.cmd('nnoremap <Leader>q <C-w>q')
-- Close buffer without losing splits
vim.cmd('nnoremap <C-c> :bp\\|bd #<CR>')

-- Break line without 
vim.cmd('nnoremap <Leader><CR> i<CR><Esc>')
vim.cmd('nnoremap <Leader><Bar> :vert sp<CR>')
vim.cmd('nnoremap <Leader>- :sp<CR>')

-- : => ;
vim.cmd('nnoremap ; :')
vim.cmd('vnoremap ; :')

-- Sudo into file to make changes
vim.cmd('cnoremap w!! w !sudo tee % >/dev/null')

-- Buffer resizing
vim.cmd('map <Leader>j :10winc +<CR>')
vim.cmd('map <Leader>k :10winc -<CR>')
vim.cmd('map <Leader>l :10winc <<CR>')
vim.cmd('map <Leader>h :10winc ><CR>')

-- Copy current file path to clipboard using xclip
vim.opt.clipboard = 'unnamedplus'
vim.cmd("nmap cp :let @+ = expand('%').':'.line('.')<CR>")

-- Misc
vim.cmd('noremap H ^')
vim.cmd('noremap L g_')
vim.cmd('noremap <Leader><Space> :nohl<CR>')
