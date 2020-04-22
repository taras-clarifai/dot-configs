# dot-configs

## Vim instructions

* Install [vim-plug](https://github.com/junegunn/vim-plug)
* [optional] Install [Python3](https://www.python.org/downloads/) and [Perl](https://www.perl.org/get.html) (you need perl for `Tags` in `fzf`)
* Put `.vimrc` in your `$HOME` and start Vim
* To install plugins, enter `:PlugInstall`
* Restart Vim
* [optional] for C++ generate tags with [Universal CTags](https://github.com/universal-ctags/ctags) with command `ctags --languages=C,C++ -R /path/to/src/dir`
* [optional] for Windows and fzf.vim modify file `~/.vim/plugged/fzf.vim/autoload/fzf/vim.vim` - replace `bash` to full path ` let s:bin.preview = escape('c:\PROGRA~1\Git\bin\bash.exe', '\').' '.escape(s:bin.preview, '\')`

[fzf search syntax](https://github.com/junegunn/fzf#search-syntax)
