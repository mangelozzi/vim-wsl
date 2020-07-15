" Converts a wsl (linux) path to a windows path
" @a:1 (optional) - Path to convert, uses current buffer if not supplied.
function! wsl#WslToWinPath(...)
    let path = get(a:, 1, expand("%:p"))
    " Shell escape will replace ' with '\'' then surround with single quotes
    let win_path = system("wslpath -w ".shellescape(path))
    let win_path = trim(win_path)
    return win_path
endfun

" Converts a path to a URI (e.g. file://filename%20with%20spaces.html)
" @a:1 (optional) - Path to convert, uses current buffer if not supplied.
function! wsl#PathToUri(...)
    let path = get(a:, 1, expand("%:p"))
    let escape_chars = {' ':'20', "'":'27','`':'60', '@':'40', '#':'23', '$':'24', '^':'5E', '&':'26', '=':'3D', '+':'2B', '[':'5B', '{':'7B', ']':'5D', '}':'7D', ';':'3B', ':':'3A', ',':'2C', '!':'21' }
    " Must substitute % first! Cause the escape symbols start with % too!
    " When one calls an external command in vim with ! once needs to escape
    " the %, ie. \%
    let uri = path
    let uri = substitute(uri, '\V'.'%', '%25', 'g')
    for key in keys(escape_chars)
        let uri = substitute(uri, '\V'.key, '%'.escape_chars[key], 'g')
    endfor
    let uri = 'file://'.uri
    return uri
endfun

" Opens the current buffer in the given browswer
" @browser     - Browser to open with (Default opens with OS default app)
"                Valid options: 'chrome' (default) or 'firefox' or 'iexplore' or 'microsoft-edge'
" @open_in     - Open the file in a new tab or window.
"                Valid values: 'tab' or 'window'.
" #use_profile - Which browser user profile to use.
"                With Chrome  valid values are integers, e.g. -1 (no profile), 1, 2, 3.
"                With Firefox valid values are profile names, e.g. "default", "default-release"
"                If you get the profile name wrong, firefox will ask you which
"                you use to select.
function! wsl#GetLuanchCommand(browser, open_in, use_profile)
    " cmd example: firefox -new-tab "\\wsl$\Ubuntu-20.04\home\michael\linkcube\foo^bar; mo'o %$\foo bar 'Copy.txt"
    " from bash:   cmd.exe /c start chrome --profile-directory="Profile 2" --new-tab "C:\code\temp.html"
    " from vim:    exe '!cmd.exe /c start chrome --profile-directory="Profile 2" --new-tab "C:\code\temp.html"'
    " NOT USED: let launch = shellescape(browser_exe, 1).' '.open_in_opt.' '.profile_opt.' '.shellescape(p, 1)
    "let launch = 'cmd.exe /c start '.shellescape(browser, 1).' '.shellescape(p, 1).''
    " Note: Use shellescape with {special} set to 1 to escape with a backslash
    " !, %, and # so the Vim ! command converts it back to a normal char.
    let p = wsl#WslToWinPath()
    " Use if else statement rather than conditional joining to make it easier
    " for exceptions and changes.
    if a:browser ==? 'chrome'
        " start chrome --profile-directory="Profile 2" --new-tab "\\wsl$\Ubuntu-20.04\home\michael\foo.html"
        let launch  = 'cmd.exe /c start chrome '
        let launch .= a:open_in ==? 'tab' ? '--new-tab ' : '--new-window '
        let launch .= a:use_profile == -1 ? '' : "--profile-directory='Profile ".a:use_profile."' "
        echom launch
        echom p
        let launch .= shellescape(p, 1)
    elseif a:browser == 'firefox'
        " If pass in a profile it doesnt recognize, will give you the option
        " to choose
        " start firefox -new-tab -P "default" "\\wsl$\Ubuntu-20.04\home\michael\foo.html"
        let launch  = 'cmd.exe /c start firefox '
        " Place the profile option before tab/window option, or else an extra
        " tab is opened.
        let launch .= a:use_profile  == -1 ? '' : "-P '".a:use_profile ."' "
        let launch .= a:open_in ==? 'tab' ? '-new-tab ' : '-new-window '
        let launch .= shellescape(p, 1)
    elseif a:browser ==? 'iexplore'
        " start iexplore "\\wsl$\Ubuntu-20.04\home\michael\foo.html"
        let launch  = 'cmd.exe /c start iexplore '
        let launch .= shellescape(p, 1)
    elseif a:browser ==? 'microsoft-edge'
        " NOT USED: let launch = shellescape(a:browser_exe, 1).' '.a:open_in_opt.' '.profile_opt.' '.shellescape(p, 1)
        let launch  = 'cmd.exe /c start microsoft-edge:'
        "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" file:///C:/MyApplications/MyTestApp.htm
        " let launch  = shellescape('/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe', 1)
        " let launch .= ' '
        let launch .= shellescape(wsl#PathToUri(p), 1)
    else
        let launch  = 'cmd.exe /c explorer.exe '
        let launch .= shellescape(p, 1)
    endif
    echom launch
    return launch
endfun

" All parameters are optional
" @1st arg = 'chrome' or 'firefox' or 'iexplore' or 'microsoft-edge', default
"            value of 'default' uses the OS default app.
" @2nd arg = 'tab' (default) or 'window' (for chrome and firefox only),
" @3rd arg = With Chrome the profile number as an int, e.g. 1 or 2 or 3. Unset or set to -1 (default) to disable profile handling.
"            With Firefox the profile name, e.g. "Default User"
function! wsl#OpenBufferInBrowser(...)
    let browser = get(a:, 1, 'default')
    let open_in = get(a:, 2, 'tab')
    let use_profile = get(a:, 3, -1)
    let launch = wsl#GetLuanchCommand(browser, open_in, use_profile)
    exe 'silent !'.launch
    redraw
    echom "Opened buffer in ".browser
endfun


function! wsl#CheckWslPath()
    echom "Checked wsl path"
endfun







