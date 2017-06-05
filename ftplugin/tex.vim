function! SyncTexForward()
    " your tex file has to be compiled with synctex
    " to do, make a different g:LatexBox_viewer name.
    
     "let execstr = "silent !okular %:p:r.pdf\\#src:".line(".")."%:p &"
     " open okular with unique instance modifier, and with full filename 
     "let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
     if &filetype == "tex"
         if g:LatexBox_viewer == "okular" 
             " remove silent to get debugging information
             let execstr = "silent !okular --unique " . LatexBox_GetOutputFile()."\\#src:".line(".")."%:p &"
         elseif g:LatexBox_viewer == "zathura"
             " for debug purposes
             if exists("g:vim_synctex_debug") && g:vim_synctex_debug == "True"
                let execstr = "silent !zathura -l 'debug' '" . LatexBox_GetOutputFile() . "' --synctex-forward=". line(".") . ":0:" . "'%:p' 2>&1 >> ~/logs/zathura &"
             else
                let execstr = "silent !zathura -l 'debug' '" . LatexBox_GetOutputFile() . "' --synctex-forward=". line(".") . ":0:" . "'%:p' &"
             endif
         endif
         echo expand(execstr)
         exec execstr
     endif
endfunction
nmap <Leader>ls :call SyncTexForward()<CR><CR>
"nmap <Leader>ls :call SyncTexForward()<CR>

