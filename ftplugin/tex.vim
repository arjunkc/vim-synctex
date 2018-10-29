function! SyncTexForward()
    " your tex file has to be compiled with synctex
    " to do, make a different g:LatexBox_viewer name.
    if ! exists("g:vim_synctex_log") 
        g:vim_synctex_log='/var/log/vim-synctex'
    endif

    if &filetype == "tex"
        if g:LatexBox_viewer == "okular" 
            " remove silent to get debugging information
            let execstr = "silent !okular --unique " . LatexBox_GetOutputFile()."\\#src:".line(".")."%:p &"
        elseif g:LatexBox_viewer == "zathura"
            " for debug purposes
            if exists("g:vim_synctex_debug") && g:vim_synctex_debug == "True" && filereadable("g:vim_synctex_log")
                let execstr = "silent !zathura -l 'debug' '" . LatexBox_GetOutputFile() . "' --synctex-forward=". line(".") . ":0:'" . expand('%:p') . "' 2>&1 >> " . g:vim_synctex_log . " &"
            else
                let execstr = "silent !zathura -l 'debug' '" . LatexBox_GetOutputFile() . "' --synctex-forward=". line(".") . ":0:'" . expand('%:p') .  "' &"
            endif
        endif
        echo expand(execstr)
        exec execstr
    endif
endfunction
nmap <Leader>ls :call SyncTexForward()<CR><CR>
"nmap <Leader>ls :call SyncTexForward()<CR>

