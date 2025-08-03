vim9script
# Vim filetype plugin file
# Language:    Futhark <https://futhark-lang.org>
# Last Change: 2025 Jul 18
# Maintainer:  AstroSnail <astrosnail@protonmail.com>
# License:     This file is placed in the public domain.

# Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif
b:did_ftplugin = 1

setlocal comments=:--
setlocal commentstring=--\ %s
