# vim-synctex

## Description

Python wrapper for gvim and vim plugin that allows you to sync back and forth between a latex file open in gvim and a pdf open in zathura or okular.

The main feature of the gvim-open script is the following: when you Ctrl-click on a line in zathura or okular, it will call gvim-open with the corresponding line number and tex file name. gvim-open will check all running gvim servers for the appropriate tex file, and go to the correct line. This makes pdf > tex file sync work. Otherwise, if you have many gvim windows open, and your pdfviewer calls:

```
gvim --remote +%{line} %{input}
```

it will result in a **new** gvim window opening each time you try to jump from the pdf to the tex file (reverse sync). The gvim-open script fixes this behavior, and looks first for a tex file that is already open in a gvim window.

## Package

The package contains a `ftplugin/tex.vim` that has tex forward search. Essentially, it calls a viewer like `zathura` with the right pdf file and line number. This requires LaTeX-Box to figure out the correct pdf file name.

This uses the default LaTeX-Box and latexsuite mapping sync mappings

    <Leader>ls

which usually corresponds to `\ls` to do tex forward search in a pdf. 
It also contains a gvim wrapper script called `bin/gvim-open`. The wrapper script does tex reverse search.  It opens the tex file, if already open, in the correct gvim instance. This is useful if you run many gvim instances.

To do reverse search you simply Ctrl-Click or Shift-Click on your pdf reader. I've tested it with zathura and okular. Evince should also work with small configuration changes.

## Requires

1.  LaTeX-Box. This is used to figure out the correct pdf file for the tex file you are editing, if it exists.
1.  gvim
1.  python 2 or 3
1.  zathura or okular
1.  latex with synctex

I've tested a reasonable amount on a linux system with zathura. Zathura is not exactly fully featured, but it has vim keybindings, so it is my preferred pdf viewer when using latex.

# Installation

## vim plugin installation


### Pathogen

If using pathogen, simply make a directory under the 'bundle' directory as follows

    cd ~/.vim/bundle
    git clone <this url>

### Vundle

## Reverse sync (pdf to gvim)

Copy `gvim-open` to your global path. `$HOME/bin/` should be in your path in most linux distributions. Then it should find the gvim executable automatically, but if it fails, simply edit the file and change the GVIM environment variable like so

    GVIM=/usr/bin/gvim

```
ln -s vim-synctex/bin/gvim-open -t /usr/local/bin/
```

## viewer setup for reverse sync

### Zathura
To configure zathura to use the gvim-open script, you copy the zathurarc script to your `~/.config/zathura` directory.

```
cp vim-synctex/zathurarc ~/.config/zathura/zathurarc
```

For zathura, edit `~/.config/zathura/zathurarc` and add the following line

    set synctex-editor-command 'gvim-open --remote +%{line} %{input}'

if your $PATH is setup correctly, and gvim-open can be found in it, then this should work.

### Okular
In okular, go to Settings > Editor > Custom Editor and add the line

   gvim-open --remote +%l %f









# Weird bugs to fix

gvim-open queries running gvim or vim processes using

```
gvim-open --remote-expr 'returnbufferlist#Buffers()' --servername <servername>
```

If the running gvim process has been suspended by linux, then this command will never return. One way to fix this is to check if the process is suspended using `ps` or some other linux mechanism. But I do not think I am going to do it. Another way to fix this is to have some sort of timeout mechanism for these commands.
