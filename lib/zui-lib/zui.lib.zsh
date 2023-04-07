#
# No plugin manager is needed to use this file. All that is needed is adding:
#   source {wherezui-is}/zui.plugin.zsh
#
# to ~/.zshrc.
#
eval "${SNIP_EMULATE_OPTIONS_ZERO:-false}"||\
    0="${${${(M)${0::=${(%):-%x}}:#/*}:-$PWD/$0}:A}"

typeset -gx ZUI_REPO_DIR="$0:h"

#
# Update FPATH if:
# 1. Not loading with Zplugin
# 2. Not having fpath already updated (that would equal: using other plugin manager)
#

if [[ -z "$ZPLG_CUR_PLUGIN" && "${fpath[(r)$ZUI_REPO_DIR]}" != $ZUI_REPO_DIR ]]; then
    fpath+=( "$ZUI_REPO_DIR" )
fi

[[ ${+fg_bold} = "0" || -z "${fg_bold[green]}" ]] && builtin autoload -Uz colors && colors

#
# Global parameters
#

typeset -gAH ZUI
typeset -ga ZUI_MESSAGES
typeset -g ZUIO
: ${ZUI[SERIALZE_FLE_PFX]:=AppState:}
: ${ZUI[SERIALZE_FLE_EXT]:=.dat}
: ${ZUI[SERIALZE_EXVAR_PFX]:=ZUI_SERIALIZED_APP_STATE___}
: ${ZUI[SERIALZE_FIELD_PFX]:=SERIALZED_APP_STATE:}
: ${ZUI[CACHE_DIR]:=${XDG_CACHE_HOME:-$HOME/.cache}/zui-zsh}
: ${ZUIO:=$ZUI[CACHE_DIR]/all-io.log}
: ${ZUI[WRONGSTR_P]:="([[:space:][:punct:][:INCOMPLETE:][:INVALID:][:IFS:]\
[:cntrl:]]|[^[:print:]])#"}
command mkdir -p $ZUI[CACHE_DIR] $ZUIO:h $ZUI_CONFIG_DIR

#
# Setup
#

# Support reloading

unset -f -m "(-|)zui[_-]*"
fpath+=("${ZUI_REPO_DIR}/functions" "${ZUI_REPO_DIR}/demos")
fpath=(${(u)fpath})
autoload -Uz -- $ZUI_REPO_DIR/functions/*[a-z](N.:t) \
                $ZUI_REPO_DIR/demos/*[a-z](N.:t)

#
# Global parameters
#

typeset -gAH ZUI
typeset -ga ZUI_MESSAGES
typeset -g ZUIO
: ${ZUI[SERIALZE_FLE_PFX]:=AppState:}
: ${ZUI[SERIALZE_FLE_EXT]:=.dat}
: ${ZUI[SERIALZE_EXVAR_PFX]:=ZUI_SERIALIZED_STATE_OF_APP___}
: ${ZUI[SERIALZE_FIELD_PFX]:=SERIALZED_STATE_OF_APP:_}
: ${ZUI[CACHE_DIR]:=${XDG_CACHE_HOME:-$HOME/.cache}/zui-zsh}
: ${ZUIO:=$ZUI[CACHE_DIR]/all-io.log}
: ${ZUI[WRONGSTR_P]:="([[:space:][:punct:][:INCOMPLETE:][:INVALID:][:IFS:]\
[:cntrl:]]|[^[:print:]])#"}
command mkdir -p $ZUI[CACHE_DIR] $ZUIO:h $ZUI_CONFIG_DIR

#
# Load modules
#

zmodload zsh/stat&&ZUI[stat_available]=1 || ZUI[stat_available]=0
zmodload zsh/datetime&&ZUI[datetime_available]=1 || ZUI[datetime_available]=0

#
# Functions
#

# Cleanup and init stubs, to be first glib
# functions called, sourcing the libraries

if (( 0 == ${+functions[-zui_glib_cleanup]} ));then
    function -zui_glib_cleanup() {
        unfunction -- -zui_glib_cleanup &>>!$ZUIO
        [[ ${ZUI[glib_sourced]} != 1 ]] && source $ZUI_REPO_DIR/glib.lzui
        [[ ${ZUI[syslib_sourced]} != 1 ]] && source $ZUI_REPO_DIR/syslib.lzui
        [[ ${ZUI[utillib_sourced]} != 1 ]] && source $ZUI_REPO_DIR/utillib.lzui
        -zui_glib_cleanup "$@"
    }
fi

if (( 0 == ${+functions[-zui_glib_init]} ));then
    function -zui_glib_init() {
        unfunction -- -zui_glib_init &>>!$ZUIO
        [[ ${ZUI[glib_sourced]} != 1 ]] && source $ZUI_REPO_DIR/glib.lzui
        [[ ${ZUI[syslib_sourced]} != 1 ]] && source $ZUI_REPO_DIR/syslib.lzui
        [[ ${ZUI[utillib_sourced]} != 1 ]] && source $ZUI_REPO_DIR/utillib.lzui
        -zui_glib_init "$@"
    }
fi

# vim:ft=zsh
