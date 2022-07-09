{
  programs.ssh.enable = true;
  programs.ssh.controlMaster = "yes";
  programs.ssh.matchBlocks = {
    snail.host = "snail";
    snail.hostname = "192.168.1.65";
    snail.port = 22;
    snail.user = "astro";
    snail.identitiesOnly = true;

    smol.host = "smol";
  #  smol.hostname = "192.168.1.73";
    smol.hostname = "192.168.1.74";
    smol.port = 22;
    smol.user = "kit";
    smol.identitiesOnly = true;

    soon.host = "soon";
    soon.hostname = "192.168.1.75";
  #  soon.hostname = "192.168.1.76";
    soon.port = 22;
    soon.user = "erry";
    soon.identitiesOnly = true;

    git.host = "git.astrosnail.pt.eu.org";
    git.hostname = "192.168.1.65";
    git.port = 22;
    git.user = "git";
    git.identitiesOnly = true;
  };
  programs.ssh.serverAliveInterval = 60;
}
