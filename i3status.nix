{
  programs.i3status.enable = true;
  programs.i3status.enableDefault = false;
  programs.i3status.general.colors = true;
  programs.i3status.general.interval = 1;
  programs.i3status.general.output_format = "i3bar";
  #programs.i3status.modules."cpu_temperature 0".position = 1;
  #programs.i3status.modules."memory".position = 2;
  #programs.i3status.modules."memory".settings.format = "%free";
  #programs.i3status.modules."disk /".position = 3;
  #programs.i3status.modules."disk /".settings.format = "%avail";
  #programs.i3status.modules."ethernet enp42s0".position = 4;
  #programs.i3status.modules."wireless wlp41s0".position = 5;
  programs.i3status.modules."time".position = 6;
  programs.i3status.modules."time".settings.format = "W%V-%u %F %T";
}
