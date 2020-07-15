echom "wsl plugin loaded"
command! -nargs=* WslBrowse :call wsl#OpenBufferInBrowser(<f-args>)

command! -nargs=* Chrome  :call wsl#OpenBufferInBrowser("chrome", "tab", <f-args>)
command! -nargs=* Firefox :call wsl#OpenBufferInBrowser("firefox", "tab", <f-args>)
command! -nargs=* IE      :call wsl#OpenBufferInBrowser("iexplore", <f-args>)
command! -nargs=* Edge    :echom "Please use a real browser. Consider using notepad.exe while you are at it."

"map  <F5>       :silent WslBrowse firefox tab default
"map! <F5> <ESC> :call myal#OpenBufferInBrowser() <CR>


augroup wsl_vim_autogroup
    " Clear existing autocmds for this group
    autocmd!
    autocmd BufNewFile    * :echom "......BufNewFile   "
    autocmd BufReadPre    * :echom "......BufReadPre   "
    autocmd FilterReadPre * :echom "......FilterReadPre"
    autocmd FileReadPre   * :echom "......FileReadPre  "
    echom "Auto commands set"
augroup END







