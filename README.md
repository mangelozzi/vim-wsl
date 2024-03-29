win32yank.exe is used by:
Copyright (c) 2015 Rui Abreu Ferreira <raf-ep@gmx.com>
<https://github.com/equalsraf/win32yank/blob/master/LICENSE>

```
*wsl-aid.txt*  WSL interface for VIM & Neovim
Author:  Michael Angelozzi <http://github.com/michael-angelozzi/>
License: Same terms as Vim itself (see |license|)


INTRODUCTION                                    *wsl*

Allows one to open files in WSL Vim with Windows installed browsers.

COMMANDS                                        *wsl-commands*

:WslBrowse {browser} {open_in} {use_profile}
                        If run with no args, opens the buffer with the default
                        Windows app for that file type.

                        {browser} specifies which browser to open the buffer
                        with.
                        Valid values: 'chrome' (default) or 'firefox' or
                        'iexplore' or 'microsoft-edge'

                        {@open_in} specifies whether to open the file in a new
                        tab or window.
                        Valid values: 'tab' or 'window'.

                        {use_profile} specifies the browser user profile.
                        With Chrome, valid values are integers,
                        e.g. -1 (no profile), 1, 2, 3.
                        With Firefox valid values are profile names,
                        e.g. "default", "default-release"
                        If you get the profile name wrong, firefox will show you
                        a selection box of valid choices. Note the value, and
                        add it to your MYVIMRC file.

:Chrome {profile_number}
:Firefox {profile_name}
:IE
:Edge
                        Like |:Wslbrowse| but already has the {browser} specified,
                        and {open_in} set to 'tab' if available.

MAPPINGS                                        *surround-mappings*

Comes with no mappings, but these can easily be created, e.g.
Examples (Menomic, F5 is used to refresh webpage):>

map <F5> :WslBrowse firefox<CR>
map <F5> :WslBrowse firefox tab<CR>
map <F5> :WslBrowse firefox window<CR>
map <F5> :WslBrowse firefox window default-release<CR>
map <F5> :WslBrowse firefox tab default<CR>
map <F5> :WslBrowse firefox tab Michael\ Angelozzi<CR>

map <F5> :WslBrowse chrome<CR>
map <F5> :WslBrowse chrome tab<CR>
map <F5> :WslBrowse chrome window<CR>
map <F5> :WslBrowse chrome window 2<CR>
map <F5> :WslBrowse chrome tab 1<CR>

map <F5> :WslBrowse iexplore<CR>

" microsoft edge doesnt open the file because of their ever changing security
" policies. But if you are using microsoft-edge, I don't recommend using Vim,
" please try something more suitable like notepad.exe.
map  <F5>       :WslBrowse microsoft-edge<CR>
<

ABOUT                                           *wsl-about*

Grab the latest version or report a bug on GitHub:

http://github.com/michael-angelozzi/vim-wsl

 vim:tw=78:et:ft=help:norl:
 ```
