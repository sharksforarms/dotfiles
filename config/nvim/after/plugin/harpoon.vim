" Example .nvimrc in project root
"nmap <leader>rh :call SendTerminalCommand(0,
            "\ "cd " . getcwd()
            "\ . " && cargo test --all "
            "\ . " && notify-send \"Test\" \"Success\" \|\| notify-send -t 100 -i /usr/share/icons/Humanity/status/16/messagebox_critical.svg \"Test\" \"Failed\""
            "\ . "\n")<CR>

nnoremap <silent><leader>th :lua require('harpoon.term').gotoTerminal(0)<CR>
nnoremap <silent><leader>tj :lua require('harpoon.term').gotoTerminal(1)<CR>
nnoremap <silent><leader>tk :lua require('harpoon.term').gotoTerminal(2)<CR>
nnoremap <silent><leader>tl :lua require('harpoon.term').gotoTerminal(3)<CR>

