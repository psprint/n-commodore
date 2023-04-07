#!/usr/bin/env zsh

autoconf.zsh() {
    local dir=$1
    integer q

    # Set options
    builtin emulate -L zsh -o extendedglob -o noshortloops \
                            -o warncreateglobal -o typesetsilent \
                            -o nopromptsubst

    # Set $0 with a new trik - use of %x prompt expansion
    0=${${${(M)${0::=${(%):-%x}}:#/*}:-$PWD/$0}:A}
    source $0:h:h/share/preamble.inc.zsh

    # -h - origin tag
    # -p - overwrite quiet mode
    # -q - quiet mode
    # -e - print to stderr
    # -n - no new line
    local -A Opts; local -a opts
    int/nc::parse-opts "h p q e n" Opts opts "$@"
    set -- "$reply[@]"

    # Custom script
    if [[ -f $dir/autogen.sh ]]; then
        q=1
        iqmsgi {pre}Found {cmd}./autogen.sh{pre} running it…
        (
            cd -q $dir||return $?
            chmod +x ./autogen.sh
            ./autogen.sh
        )
    # Autoreconf only if available in PATH
    elif [[ -f $dir/configure && -f $dir/configure.ac && \
            $+commands[autoreconf] = 1 ]]; then
        q=1
        iqmsg {pre}Running {cmd}autoreconf {opt}-f{%}…
        (
            cd -q $dir||return $?
            rm -f aclocal.m4
            aclocal -I m4 --force
            libtoolize --copy --force
            autoreconf -f -i -I m4
        )
    # Manual reproduction of autoreconf run
    elif [[ -f $dir/configure && -f $dir/configure.ac ]]; then
        q=1
        iqmsg {pre}Running {cmd}aclocal{pre}, {cmd}autoconf{pre} and {cmd}automake
        (
            cd -q $dir||return $?
            rm -f aclocal.m4
            aclocal -I m4 --force
            libtoolize --copy --force
            aclocal -I m4 --force
            autoconf -I m4 -f
            autoheader -I m4 -f
            automake --add-missing -c --force-missing
        )
    # Only autoconf if no existing ./configure
    elif [[ ! -f $dir/configure && -f $dir/configure.ac ]]; then
        q=1
        iqmsg {pre}Running {cmd}autoconf {opt}-f{%}…
        (
            cd -q $dir||return $?
            autoconf -f -I m4
        )
    else
        iqmsgi {err}No {cmd}autogen.sh{err} nor {file}configure.ac\
            {err}found
    fi
    if [[ ! -f $dir/configure ]]; then
        if (( q )); then
            iqmsgi Some input files existed \({file}configure.ac{%},\
                etc.\) however running {cmd}Autotools{%} didn\'t \
                yield a {cmd}./configure{%} script, meaning that \
                it won\'t be run\! \
                Please check if you have packages such as \
                {pkg}autoconf{%}, {pkg}automake{%} and similar \
                installed.
        else
            # No output – lacking both configure.ac and configure → a no-op
            :
        fi
    fi
} # ]]]

autoconf.zsh "$@"
