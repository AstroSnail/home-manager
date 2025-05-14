{
  nixpkgs.overlays = [
    #(final: prev: {
    #  readline = prev.readline.overrideAttrs (oldattrs: {
    #    patches = oldattrs.patches ++ [ ./readline.patch ];
    #  });
    #})
  ];

  programs.readline.enable = true;
  programs.readline.includeSystemConfig = false;
  #programs.readline.variables.bell-style = "visible";
  programs.readline.variables.colored-stats = true;
  programs.readline.variables.completion-ignore-case = true;
  programs.readline.variables.completion-map-case = true;
  # query (triggered by show-all-if-ambiguous) breaks menu-complete
  programs.readline.variables.completion-query-items = -1;
  # leave this to the shell
  #programs.readline.variables.editing-mode = "vi";
  # reduce lag when just pressing esc
  programs.readline.variables.keyseq-timeout = 100;
  # convenient for using / to end menu-complete
  # more trouble than it's worth
  #programs.readline.variables.mark-directories = false;
  programs.readline.variables.match-hidden-files = false;
  programs.readline.variables.menu-complete-display-prefix = true;
  #programs.readline.variables.page-completions = false;
  programs.readline.variables.revert-all-at-newline = true;
  programs.readline.variables.show-all-if-ambiguous = true;
  # non-functional with menu-complete
  #programs.readline.variables.show-all-if-unmodified = true;
  programs.readline.variables.show-mode-in-prompt = true;
  # doesn't skip directory markers???
  # broken with menu-complete
  # still better than nothing
  programs.readline.variables.skip-completed-text = true;
  programs.readline.variables.visible-stats = true;

  # the way the module distinguishes keynames from keyseqs is inadequate
  # so programs.readline.bindings is unusable
  programs.readline.extraConfig = ''
    tab: menu-complete

    $if term=linux
    # meta-tab doesn't work??? TODO: investigate
    "\e\t": menu-complete-backward
    $endif

    $if term=xterm
    "\e[Z": menu-complete-backward
    $endif
  '';
}
