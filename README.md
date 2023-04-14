# N-Commodore – a novel file manager/shell/command-line

A new approach to the command line:

it’s a merge of Midnight Commander and command line,
… because everything is panelized, greppable and remembered,
you enter commands like ls, mv, cp, cat and have their output captured, always,
then you can save the output via Ctrl-X (to a GDBM database) and visit it back with Ctrl-Shift-Left/Right,
the screen save includes complete state like: current working directory, grep keywords, cursor position, etc.
I’m hoping that it’ll gain some attention, because by accident I might have discovered a fully novel, unprecedented approach to file managers/command line.
 
Pressing `ENTER` on any line will open `$VISUAL`/`$EDITOR`/`$PAGER` scrolled to
that line (if in file preview, otherwise, if poiting to the file, it will just open the file in editor).

Any view can be greped – `n-commodore open` starts with search prompt active, so you
can enter the search-keyword to have either files, file preview, or previous commands (views F1, F2, F3) filtered with it. Multiple keywords are allowed.

# Asciicast

[![asciicast](https://asciinema.org/a/577630.svg)](https://asciinema.org/a/577630)
