![ZUI logo](https://raw.githubusercontent.com/wiki/zdharma/zui/img/zui_logo-fs8.png)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=D6XDCHDSBDSDG)

# ⬢ ZUI – CGI+DHTML-like User Interface Library for Zsh / ZCurses

[![License (GPL version 3)](https://img.shields.io/badge/license-GNU%20GPL%20version%203-blue.svg?style=flat-square)](./LICENSE)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](./LICENSE)
![ZSH 4.3.17](https://img.shields.io/badge/zsh-v4.3.17-orange.svg?style=flat-square)

![Dharma logos](https://raw.githubusercontent.com/wiki/zdharma/zui/img/logo_theme-fs8.png)

This is a RAD (Rapid Application Development) textual user interface library for Zsh. It in many aspects resembles typical CGI+(D)HTML setup. There are:

* generators ran on "server" side (basic Zshell-code that is just generating text!),
* event loop that turns the generated text into document with active elements (buttons, anchors, toggle buttons, text fields, list boxes),
* mechanism to regenerate document parts from the original generators.

So, a Zshell code generates text. It is then turned into document with hyperlinks. DHTML-like calls are possible that will regenerate document parts on the fly. Page can be also reloaded with input data, just like an HTML page.

A voiced [video tutorial](https://youtu.be/TfZ8b_RS_Bg) shows how to create an application – Nmap network scanner frontend.

## Hello World

```zsh
# Started from Zle or from command line

-zui_glib_cleanup deserialize:"zui-demo-hello-world"
-zui_glib_init app:"zui-demo-hello-world" app_name:"ZUI Hello World"
emulate -LR zsh -o extendedglob -o typesetsilent -o warncreateglobal
-zui_glib_init2 # after emulate -LR

-zui_glib_store_default_app_config b:border 1

demo_generator_A() {
    local mod="$1" ice="$2"

    # Content, no hyper-links
    reply=( "Hello World from ${ZUI[YELLOW]}ZUI${ZUI[FMT_END]}! Module $mod, instance $ice." )

    # Non-selectable lines   Hops to jump with [ and ]   Local anchors
    reply2=( )               reply3=( 1 )                reply4=( )
}

## Start application ##
zui-event-loop 1:demo_generator_A

-zui_glib_cleanup serialize
```

![Hello World screenshot](https://raw.githubusercontent.com/wiki/zdharma/zui/img/hello-world-fs8.png)

Other example which uses list-box: [zui-demo-items-box](https://github.com/zdharma/zui/blob/master/demos/zui-demo-items-boxes)

The API is described at the [wiki](https://github.com/zdharma/zui/wiki). Checkout [screenshots](https://github.com/zdharma/zui/wiki/Screenshots)
and [Asciinema recordings](https://github.com/zdharma/zui/wiki/Asciinema).

## Installation

**The plugin is "standalone"**, which means that only sourcing it is needed. So to
install, unpack `zui` somewhere and add

```zsh
source {where-zui-is}/zui.plugin.zsh
```

to `zshrc`.

If using a plugin manager, then `Zplugin` is recommended, but you can use any
other too, and also install with `Oh My Zsh` (by copying directory to
`~/.oh-my-zsh/custom/plugins`).

### Zplugin

Add `zplugin load zdharma/zui` to your `.zshrc` file. Zplugin will handle
cloning the plugin for you automatically the next time you start zsh. To update
(i.e. to pull from origin) issue `zplugin update zdharma/zui`.

### Antigen

Add `antigen bundle zdharma/zui` to your `.zshrc` file. Antigen will handle
cloning the plugin for you automatically the next time you start zsh.

### Oh-My-Zsh

1. `cd ~/.oh-my-zsh/custom/plugins`
2. `git clone git@github.com:zdharma/zui.git`
3. Add `zui` to your plugin list

### Zgen

Add `zgen load zdharma/zui` to your .zshrc file in the same place you're doing
your other `zgen load` calls in.
