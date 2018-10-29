# vim-synctex

## Description

Python wrapper for gvim and vim plugin that allows you to sync back and forth between a latex file open in gvim and a pdf open in zathura or okular.

The main feature of the gvim-open script is the following: when you Ctrl-click in zathura, it will call gvim-open with the corresponding line number and tex file name. gvim-open will check all gvim servers for the appropriate open tex file, and go to the correct line. This makes pdf > tex file sync work. Otherwise, if you have many gvim windows open, and your pdfviewer calls:

```
gvim --remote +%{line} %{input}
```

This will result in a **new** gvim window opening each time you try to go jump from the pdf to the tex file. The gvim-open script fixes this behavior, and looks first for a tex file that is already open in a gvim window.

## Requires

1.  gvim
1.  python 2 or 3
1.  zathura or okular
1.  latex with synctex

I've tested a reasonable amount on a linux system with zathura. Zathura is not exactly fully featured, but it has vim keybindings, so it is my preferred pdf viewer when using latex.

## Installation

If using pathogen, simply make a directory under the 'bundle' directory as follows

```
cd ~/.vim/bundle
git clone http://github.com/arjunkc/vim-synctex.git vim-synctex
```

This will enable forward sync. If you want to enable reverse sync with gvim, you must use link the gvim-open python script.

```
ln -s vim-synctex/bin/gvim-open -t /usr/local/bin/
```

To configure zathura to use the gvim-open script, you copy the zathurarc script to your `~/.config/zathura` directory.

```
cp vim-synctex/zathurarc ~/.config/zathura/zathurarc
```

You may choose to merge the files instead if you already have one. The relevant line  in the zathurarc file is

```
set synctex-editor-command 'gvim-open --remote +%{line} %{input}'
```



