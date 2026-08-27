vim9script

# bad: xterm gets special treatment
# def: builtin xterm
# DEF: builtin always
# req: requested from termcap (e.g. if nottybuiltin)
# cap: termcap exists for xterm

# standard caps (only the bad ones)
# fs KS_FS  bad def req
# ts KS_TS  bad def req
# ve KS_VE  bad def req cap
# vs KS_VS  bad def req cap

# non-standard caps
# AU KS_CAU bad def req
# Ce KS_UCE         req
# Cs KS_UCS         req cap
# CF KS_CF      DEF req
# Us KS_USS         req
# ds KS_DS          req
# Ds KS_CDS         req
# Te KS_STE bad def req
# Ts KS_STS bad def req
# IS KS_CIS bad def req
# IE KS_CIE bad def req
# WP KS_CWP bad def
# GP KS_CGP bad def
# WS KS_CWS bad def req
# VS KS_CVS bad def req
# SI KS_CSI         req
# SR KS_CSR             cap
# EI KS_CEI         req
# RV KS_CRV     def req cap
# XM KS_CXM     def req cap
# RK KS_CRK bad def req
# u7 KS_U7      def req cap
# RF KS_RFG bad def req
# RB KS_RBG bad def req
# 8f KS_8F      DEF req
# 8b KS_8B      DEF req
# 8u KS_8U  bad DEF req
# BE KS_CBE     def req cap
# BD KS_CBD     def req cap
# SC KS_CSC bad def req
# EC KS_CEC bad def req
# SH KS_CSH bad def
# RC KS_CRC bad def
# RS KS_CRS bad def
# ST KS_CST bad def req
# RT KS_CRT bad def req
# Si KS_SSI bad def req
# Ri KS_SRI bad def req
# TE KS_CTE bad def req
# TI KS_CTI bad def req
# fe KS_FE  bad def     cap
# fd KS_FD  bad def     cap
# BS KS_BSU     DEF
# ES KS_ESU     DEF

# there seems to be a general pattern: if a vim cap is builtin xterm
# and not requested from an existing termcap, it's special treatment
# for xterm, otherwise not. this makes the feature less usable in
# xterm-like terminals that aren't known to vim.
# exceptions:
# - ve and vs because vim uses a non-standard interpretation of them
# - 8u because vim uses the RV response to guess whether the terminal
#   really supports it
# - RK, TI and TE are set based on keyprotocol (which contains xterm:mok2 by
#   default)
# - not all terminals have the same caps as xterm (e.g. vte doesn't
#   have fd and fe, though that doesn't matter here)

# initialize all non-standard caps. assume terminal is xterm-like and won't
# choke on unknown termcodes

&t_ts = "\<Esc>]2;"
&t_fs = "\<Esc>\\"
&t_vi = "\<Esc>[?25l"
&t_ve = "\<Esc>[?25h"
&t_vs = "\<Esc>[?12h"
&t_VS = "\<Esc>[?12l"
&t_AU = "\<Esc>[58;5;%dm"
&t_Ce = ''
&t_Cs = ''
&t_Us = "\<Esc>[21m"
&t_ds = ''
&t_Ds = ''
&t_Te = "\<Esc>[29m"
&t_Ts = "\<Esc>[9m"
&t_IS = "\<Esc>]1;"
&t_IE = "\<Esc>\\"
&t_WP = "\<Esc>[3;%p1%d;%p2%dt"
&t_GP = "\<Esc>[13t"
&t_WS = "\<Esc>[8;%p1%d;%p2%dt"
&t_SI = "\<Esc>[6 q"
&t_SR = "\<Esc>[4 q"
&t_EI = "\<Esc>[2 q"
&t_RV = "\<Esc>[>c"
&t_XM = "\<Esc>[?1006;1000%?%p1%{1}%=%th%el%;"
&t_u7 = "\<Esc>[6n"
&t_RF = "\<Esc>]10;?\<Esc>\\"
&t_RB = "\<Esc>]11;?\<Esc>\\"
&t_BE = "\<Esc>[?2004h"
&t_BD = "\<Esc>[?2004l"
&t_SC = "\<Esc>]12;"
&t_EC = "\<Esc>\\"
&t_SH = "\<Esc>[%p1%d q"
&t_RC = "\<Esc>[?12$p"
&t_RS = "\<Esc>P$q q\<Esc>\\"
&t_ST = "\<Esc>[22;2t"
&t_RT = "\<Esc>[23;2t"
&t_Si = "\<Esc>[22;1t"
&t_Ri = "\<Esc>[23;1t"
&t_fe = "\<Esc>[?1004h"
&t_fd = "\<Esc>[?1004l"

# if a terminal doesn't support 8u it probably doesn't support AU either
autocmd TermResponse * {
	if &t_8u == ''
		&t_AU = ''
	endif
}

set keyprotocol+=vim:mok2,vte:none
# (test vscode with \e[?4m and \e[?u)
# vim terminal might support kitty? needs testing
# vim terminal keyprotocol is crippled by terminal_alt_sends_escape.vim
# what do?
# vim can correctly guess 8u support in xterm, vte, vim
# (test vscode)
