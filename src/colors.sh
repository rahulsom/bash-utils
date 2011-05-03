#!/bin/bash
#

# Reset
ansi_reset ()     { echo -e -n "\033[00;0m"; }

# Effects
ansi_bold ()      { echo -e -n "\033[00;1m"; }
ansi_italics ()   { echo -e -n "\033[00;3m"; }
ansi_underline () { echo -e -n "\033[00;4m"; }
ansi_inverse ()   { echo -e -n "\033[00;7m"; }
ansi_strike ()    { echo -e -n "\033[00;9m"; }

# Reverse effects
ansi_nbold ()      { echo -e -n "\033[00;22m"; }
ansi_nitalics ()   { echo -e -n "\033[00;23m"; }
ansi_nunderline () { echo -e -n "\033[00;24m"; }
ansi_ninverse ()   { echo -e -n "\033[00;27m"; }
ansi_nstrike ()    { echo -e -n "\033[00;29m"; }

# Foreground
ansi_fg_black()   { echo -e -n "\033[00;30m"; }
ansi_fg_red()     { echo -e -n "\033[00;31m"; }
ansi_fg_green()   { echo -e -n "\033[00;32m"; }
ansi_fg_yellow()  { echo -e -n "\033[00;33m"; }
ansi_fg_blue()    { echo -e -n "\033[00;34m"; }
ansi_fg_magenta() { echo -e -n "\033[00;35m"; }
ansi_fg_cyan()    { echo -e -n "\033[00;35m"; }
ansi_fg_white()   { echo -e -n "\033[00;37m"; }
ansi_fg_default() { echo -e -n "\033[00;39m"; }

# Background
ansi_bg_black()   { echo -e -n "\033[00;40m"; }
ansi_bg_red()     { echo -e -n "\033[00;41m"; }
ansi_bg_green()   { echo -e -n "\033[00;42m"; }
ansi_bg_yellow()  { echo -e -n "\033[00;43m"; }
ansi_bg_blue()    { echo -e -n "\033[00;44m"; }
ansi_bg_magenta() { echo -e -n "\033[00;45m"; }
ansi_bg_cyan()    { echo -e -n "\033[00;45m"; }
ansi_bg_white()   { echo -e -n "\033[00;47m"; }
ansi_bg_default() { echo -e -n "\033[00;49m"; }

