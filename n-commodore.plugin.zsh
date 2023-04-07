# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4;-*-

# Copyright (c) 2023 Sebastian Gniazdowski

integer EC=0
0="${ZERO:-${${${(M)${0::=${(%):-%x}}:#/*}:-$PWD/$0}:A}}"
local ZERO="$0"
[[ -f $0 ]];EC+=$?

# Read the common setup code, to create the $NC*… vars and aliases, etc.
builtin source $0:h/share/preamble.inc.zsh --script
EC+=$?

builtin unset ZERO

return EC
# vim:ft=zsh:tw=80:sw=4:sts=4:et:foldmarker=[[[,]]]