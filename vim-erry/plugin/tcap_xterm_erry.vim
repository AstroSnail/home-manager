vim9script

if &term == 'xterm-erry'

# prefer terminfo over builtin.
# the builtin output descriptions are fine (inconsequential differences in me
# and ue, more important fixes done below), but the input descriptions can
# cause surprising problems (see #17331).
# a change in ttybuiltin only takes effect after setting term too, even inside
# vimrc.
&ttybuiltin = false
&term = &term

# vim, after reverting patch 9.1.1114, is perfectly capable of detecting
# whether the terminal supports 16 million colors, but for some reason the
# setting (sometimes!) doesn't apply until an action is performed by the user.
# lacking another way of reading the XTGETTCAP RGB response, the next best
# option is simply setting termguicolors when the terminal has the right name.
# &termguicolors = true
# vim is also capable of detecting whether the terminal's background color is
# light or dark in order to change the syntax palette appropriately, but much
# like the previous problem it sometimes (much less often) doesn't apply it
# immediately (reproducers include `vim --clean --cmd 'term bc'`, or a more
# elaborate setup involving loading a session containing a regular file, a
# :Man page and a :terminal).
# &background = 'dark'
# workarounds for both problems are provided above, but i decided that i can
# tolerate bugs that only affect vim's appearance on startup.

# vim supports several underline styles: normal, curly, double, dotted and
# dashed. to achieve this, it uses termcap capabilities that define how to
# start and end each style. us and ue are standard caps for starting and
# ending normal underline respectively. as for the others, vim declares
# extension caps: Cs, Us, ds and Ds to start each, Ce to end all.
# despite the nonstandard use of these caps, vim may request their definitions
# from termcap (e.g. if term=xterm and builtin_xterm doesn't define Cs, it's
# taken from the termcap environment, if available).
# on my system, termcap is emulated by ncurses, which interprets two of those
# extension caps differently:
# - Cs is a user-defined cap to "set cursor color", intended for tmux to take
#   advantage of the feature in xterm (defined in the xterm+tmux fragment,
#   used in all of the "modern" xterm descriptions);
# - ds is a standard cap to "disable status line" (defined in the dec+sl
#   fragment, used in xterm-p371, and the xterm+sl fragment, used in several
#   terminal emulator descriptions).
# xterm implements only normal and double underline. the rest are cleared out
# here to avoid problems. vim automatically falls back to ue to end all
# underline styles when Ce is not available.
# (that said, besides normal underline, curly underline seems geared towards
# the gui, and the rest of the underline style repertoire seems overlooked in
# the themes and syntax highlight files distributed with vim)
&t_Cs = ''
&t_Us = "\<Esc>[21m"
&t_ds = ''
&t_Ds = ''
&t_Ce = ''

# there are more conflicts, but they're relatively benign:
# - CF, CV, IS, PS, RC, RF, RK, RT and Te are historical (obsolete)
#   AT&T/XENIX/user extensions documented in ncurses, some of which have
#   standard equivalents;
# - vim uses RF to "request terminal foreground color", ncurses documents it
#   to "send next input char" (but it's unused in the distributed terminfo
#   database);
# - vim uses SC to "set cursor color start" (paired with EC to "set cursor
#   color end"), ncurses documents it to "set clock" (but it's unused in the
#   distributed terminfo database) (note that ncurses documents the Cs
#   user-defined cap to perform the same behavior as SC and EC, but vim can't
#   use it because it uses Cs to "start undercurl mode", described above).
#
# some conflicts are even safe because vim doesn't request them from termcap:
# - vim says CS is "cursor relative to scroll region" (set by default only if
#   term=pcterm), ncurses documents it to "switch cursor keys to application
#   mode" (user-defined cap intended for screen, but it's unused in the
#   distributed terminfo database);
# - vim uses RC to "request terminal cursor blinking" (set by default only in
#   builtin_xterm), ncurses documents it to "remove clock" (defined for some
#   wyse terminal descriptions);
# - vim uses SR to "start replace mode" (for setting the cursor style),
#   ncurses documents it to "scroll back n lines" (the parameterized version
#   of sr, it's a very common capability).

# vim supports setting specific cursor colors and shapes when starting insert
# mode, replace mode, or ending either mode. to achieve this, it declares
# extension termcap capabilities: SI, SR and EI respectively.
# vim doesn't supply defaults for these caps; instead, the user is intended to
# define them to their taste. comments in vim source code suggest setting the
# cursor shape to a bar for SI, underline for SR, and block for EI. xterm
# implements all of these cursor shapes, so we set them here.
&t_SI = "\<Esc>[6 q"
&t_SR = "\<Esc>[4 q"
&t_EI = "\<Esc>[2 q"

# vim supports setting whether the cursor should be visible and whether it
# should blink. to achieve this, it uses termcap capabilities that define how
# to start and end each mode. vi and vs are standard caps for making the
# cursor invisible and very visible respectively (the distributed terminfo
# database defines vs to make the cursor visible and blink). as for resetting
# these modes, a single standard cap is provided which resets both: ve "make
# cursor appear normal".
# vim instead interprets ve to only reset the effect of vi, and declares an
# extension cap VS to reset the effect of vs (assumed to only affect blinking
# state). when provided a definition of ve that resets blinking, any blinking
# cursor effect (e.g. through SI, SR and EI above, or through the :terminal)
# is immediately reset.
# blinking is nice in appropriate contexts, so fix these caps vim's way.
&t_ve = "\<Esc>[?25h"
&t_vi = "\<Esc>[?25l"
&t_vs = "\<Esc>[?12h"
&t_VS = "\<Esc>[?12l"

# vim supports setting the terminal window title. to achieve this, it uses
# termcap capabilities that define how to move to and return from the status
# line, ts and fs respectively, assuming that their definitions actually
# compose an OSC 2 sequence that sets the window title. when provided caps
# that access a real status line, vim neglects to clear it before updating the
# title, causing garbage to accumulate.
# one possible solution is to append ce "clear to end of line" to ts, like so:
# &t_ts = &t_ts .. &t_ce
# but if we have a window title it's probably better to just set ts and fs to
# OSC 2 like vim expects.
&t_ts = "\<Esc>]2;"
&t_fs = "\<Esc>\\"

endif
