#!/usr/bin/env zsh
# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4;-*-

# Copyright (c) 2023 Sebastian Gniazdowski

# Exit code, assign 0 by default (no silent option yet)
integer EC=0

# Parse any options given to this preamble.inc.zsh file
local -A Opts=()
builtin zparseopts \
    ${${(M)ZSH_VERSION:#(5.[8-9]|6.[0-9])}:+-F} \
        -D -E -A Opts -- -fun -script -cleanup||return 18

# Set options
(($+Opts[--fun]))&&builtin emulate -L zsh \
                        -o extendedglob \
                        -o warncreateglobal -o typesetsilent \
                        -o noshortloops -o nopromptsubst \
                        -o rcquotes

integer QIDX=${@[(i)(--|-)]}
((QIDX<=$#))&&builtin set -- "$@[1,QIDX-1]" "$@[QIDX+1,-1]"
# Set $0 with a new trick - use of %x prompt expansion
0=${${${(M)${0::=${(%):-%x}}:#/*}:-$PWD/$0}:A}

zmodload zsh/terminfo zsh/termcap zsh/system zsh/datetime
local QC
(($+Opts[--cleanup]))&&QC='print -n $terminfo[rmcup]$termcap[te]'
# Unset helper function on exit
(($+Opts[--fun]))&&{builtin trap 'builtin unset -f -m tmp/\*&>>|$NCNUL;
            builtin unset NCHD&>>|$NCNUL;'$QC EXIT;EC+=$?;}

# Standard hash `Plugins` for plugins, to not pollute the namespace
# NC is a hash for iqmsg color theme and for the body of all aliases
typeset -gA Plugins NC
Plugins[N-COMMODORE_SYSTEM_DIR]="${0:h:h}"
export NCCACHE="${XDG_CACHE_HOME:-$HOME/.cache}/n-commodore"
export NCDIR="${0:h:h}" \
       NCAES="${0:h:h}"/aliases \
       NCNICK=${NCNICK:-N-Commodore} \
       NCSTRDB="${0:h:h}"/strdb \
       NCTXT="${0:h:h}/share/txt" \
       NCCFG="${XDG_CONFIG_HOME:-$HOME/.config}/n-commodore/n-commodore.rc" \
       NCCHIST="$NCCACHE/n-commmodore-cmd.hst" \
       NCSHIST="$NCCACHE/n-commmodore-srch.hst" \
       NCSCRDB="$NCCACHE/screens.db" \
       NCLOG="$NCCACHE/io.log" \
       \
       NCNUL=/dev/null \
       NCDBG=/tmp/reply

[[ ! -f $NCCFG ]]&&\
    {command mkdir -p -- $NCCFG:h;cp -vf "$NCDIR/n-commodore.rc" "$NCCFG";}

# Standard work variables
typeset -g -a reply match mbegin mend
typeset -g REPLY MATCH; integer MBEGIN MEND

# fpath-saving for main script sourcing
if ((!$+Opts[--fun]||$+Opts[--script]))&&\
        [[ $ZERO == */n-commodore.plugin.zsh ]]
then
    local -Ua fpath_save=($fpath)
fi

# fpath extending for a plugin.zsh sourcing
if ((!$+Opts[--fun]&&!fpath[(I)$NCDIR]))&&\
        [[ $ZERO != */n-commodore.plugin.zsh ]]
then
    fpath+=("$NCDIR" "$NCDIR/functions")
fi

# Localize path and fpath for procedures
if (($+Opts[--fun]));then
    local -Uxa fpath=($NCDIR/{bin,functions,libexec} $fpath) \
                path=($NCDIR/{bin,functions,libexec} $path)
    local -x FPATH PATH
elif [[ $ZERO == */n-commodore.plugin.zsh ]];then
    # Unconditionally extend path for plugin source
    fpath[1,0]=($NCDIR/{bin,functions,libexec})
fi

# Uniquify paths
typeset -gU fpath FPATH path PATH

# Autoload via fpath, not direct paths
autoload -z $NCDIR/functions/*~(*~|*/THROW|*/CATCH)(.N:t) \
            $NCDIR/functions/*/*~(*~|*/ok/qlocal)(.N:t2) \
            $NCDIR/bin/*~*~(.N:t)

# Special functions that need direct loading
builtin autoload +zX ok/qlocal THROW CATCH

#
# Simple, small support messaging system
#

# Header with (%)-expansion
NC[head-txt]="%F{41}%B[%b$NCNICK%B]"\
"%F{27}[%b\${\${(%):-%x}:t}:\${(%):-%I}%B]%b: %B%F{203}Error:%b"
local NCHD=$NC[head-txt]

#
# Remaining tasks: aliases and vars reset
#
# Set up aliases
[[ -z $NC[WRONGSTR] || $(type -w 2>&1 int/nc::reset) == *:\ none ]]&&\
    if ! nc::setup-aliases || [[ -z $NC[WRONGSTR] ]];then
        EC+=!$?
        builtin print -P -- $NCHD ${(%)NC[Q1_ALIASES_NOT_SETUP]}
    fi

# Test autoload by resetting work vars
if ! int/nc::reset;then
    EC+=$?
    builtin print -P -- $NCHD ${(%)NC[Q3_AUTOLOAD_NOT_CORRECT]}
fi

#
# Cleanup:
#

## - Restore fpath if it's ZINIT sourcing, it saves fpath internally
(($+fpath_save))&&fpath=($fpath_save)

## Return EC value
return EC
