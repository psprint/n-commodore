# Zstyles

The values being set are the defaults:

```zsh
zstyle ":plugin:zui" colorpair "white/black"         # Default text color. For Zsh >= 5.3, color "default"
                                                     # is available, it might be e.g. transparent (depends
                                                     # on terminal configuration)
zstyle ":plugin:zui" border "no"                     # No border around main window
zstyle ":plugin:zui" border_cp "yellow/black"        # Border (and header) color
zstyle ":plugin:zui" bold "no"                       # No default bold

zstyle ":plugin:zui" status_colorpair "white/black"  # The same as "colorpair", but for status window
zstyle ":plugin:zui" status_border "no"
zstyle ":plugin:zui" status_border_cp "green/black"  # Border color of status window
zstyle ":plugin:zui" status_bold "no"

zstyle ":plugin:zui" mark "red reverse lineund" # String starting with one or two color names continued
                                                # with combination of: reverse, underline, blink, bold,
                                                # lineund, linerev. Last two underline, reverse whole
                                                # active line. The rest marks active button. Uppercase
                                                # color names are for background.
zstyle ":plugin:zui" altmark "red reverse"      # As "mark", but for terminals without underline support
zstyle ":plugin:zui" mark2 "yellow reverse"     # The same as "mark", but for buttons with background color
zstyle ":plugin:zui" altmark2 "yellow reverse"  # The same as "altmark", but for "mark2"

zstyle ":plugin:zui" status_size "4"            # Height of status window, including border (drawn or not)
zstyle ":plugin:zui" status_pointer "yes"       # Show line indicating position in document

zstyle ":plugin:zui" log_append "above"         # Put log messages on top of others. Also available: "below"
zstyle ":plugin:zui" log_time_format "[%H:%M] " # Display hour:minute time stamp. Set to "" to disable
zstyle ":plugin:zui" log_index "yes"            # Show order number of log messages
zstyle ":plugin:zui" log_size "32"              # How many log messages to keep in memory

zstyle ":plugin:zui" top_anchors "yes"          # Show anchors to each module instance at top

# The colors used for log messages. First two are for message's index and time stamp
zstyle ":plugin:zui" log_colors "white cyan yellow green cyan red magenta yellow blue"

# Implementation Zstyles
zstyle ":plugin:zui" select_mode "no-restart"   # What to do on non-hyperlink selection. Will invoke -zui-standard-sel\
                                                # ect-callback() passing segment or whole line as argument. Plus, will
                                                # set ZUI[pure_text_selected] or ZUI[line_selected]. If set to "restart"
                                                # then list restart will be performed, otherwise the same. If set to
                                                # "quit" then event loop will be exited, and REPLY will be set to line
                                                # or segment, otherwise the same
zstyle ":plugin:zui" text_mode "all"            # Navigate across each bit of text, not only hyperlinks. "hyp" – only
                                                # at lines with hyperlinks, "nohyp" – only at lines with no hyperlinks,
                                                # "off" - text-bit navigation fully turned off
zstyle ":plugin:zui" text_select "yes"          # Allow selection on non-hyperlinks (full lines when text_mode is "off"
                                                # or "hyp" – meaning text-bit mode fully turned off or enabled only for
                                                # lines with hyperlinks, leaving text-only lines undivided)
zstyle ":plugin:zui" timeout "-1"               # No calls to -zui-standard-timeout-callback. Denotes milliseconds.
                                                # Minimum value is 200. Time is counted when there is no user input.
```

Each application can override those via "...:app:{name}" zstyles, e.g. for application "zplugin":

```zsh
zstyle ":plugin:zui:app:zplugin" colorpair "250/17"              # 256 colors – zsh >= 5.3; "default" color also from this version
zstyle ":plugin:zui:app:zplugin" border_cp "33/17"               # Border (and header) color
zstyle ":plugin:zui:app:zplugin" border "yes"
zstyle ":plugin:zui:app:zplugin" bold "yes"
zstyle ":plugin:zui:app:zplugin" mark "blue WHITE reverse bold lineund"
zstyle ":plugin:zui:app:zplugin" altmark "green CYAN bold reverse"
zstyle ":plugin:zui:app:zplugin" status_size "4"                # More space for long messages

zstyle ":plugin:zui:app:zplugin" text_mode "nohyp"              # Text-navigation when no hyperlinks
zstyle ":plugin:zui:app:zplugin" text_select "false"
zstyle ":plugin:zui:app:zplugin" log_time_format "[%H:%M:%S] "  # hour:minute:second time stamp of log messages
```
