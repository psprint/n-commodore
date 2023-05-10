[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=D6XDCHDSBDSDG)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [N-Commodore – a novel file manager/shell/command-line](#n-commodore--a-novel-file-managershellcommand-line)
- [More in-depth explanation](#more-in-depth-explanation)
- [Asciicast](#asciicast)
- [Installation](#installation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# N-Commodore – a novel file manager/shell/command-line

A new approach to the command line:

- it’s a merge of Midnight Commander and command line,
- … because everything is panelized, greppable and remembered,
- you enter commands like ls, mv, cp, cat and have their output captured, always,
- then you can save the output via Ctrl-X (to a GDBM database) and visit it back with Ctrl-Shift-Left/Right,
- the screen save includes complete state like: current working directory, grep keywords, cursor position, etc.

I’m hoping that it’ll gain some attention, because by accident I might have discovered a fully novel, unprecedented approach to file managers/command line.
 
Pressing `ENTER` on any line will open `$VISUAL` / `$EDITOR` / `$PAGER` scrolled to
that line (if in file preview, otherwise, if poiting to the file, it will just open the file in editor).

Any view can be greped – `n-commodore` starts with search prompt active, so you
can enter the search-keyword to have either files, file preview, or previous com
 mands (views F1, F2, F3) filtered with it. Multiple keywords are allowed.

# More in-depth explanation

Basically it's about 3 factors:
- panelize everything,
- grep everything,
- save everything.

Panelization is known from Midnight Commander - it means to capture command output into a list that can be browsed. Grepping is known from fzf. Screen saving is a new paradigm

You basically have new screen (a greppable panel) for each new command, which is saved to the disk (GDBM), and which can be fetched/navigated to, having also PWD dir and position in panel restored.

# Asciicast

[![asciicast](https://asciinema.org/a/578349.svg)](https://asciinema.org/a/578349)

# Installation
**NEW**: AppImages are [available](https://github.com/psprint/n-commodore/releases).

Clone the repo and symlink `$PWD/bin/n-c` (full path) to a directory in your `$PATH`, like `/usr/local/bin`, After this, run `n-c` for the file manager.

… or, if using Zsh, load the plugin file `n-commdore.plugin.zsh` either directly
(`source …`) or via a plugin manager, like zinit
(`zinit for psprint/n-commodore`). This creates a `nc` alias which you can use
to start the file manager. You can define a variable `NC_NO_NICKNAME_CMD=1` to
skip alias creation.