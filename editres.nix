{ pkgs, ... }:

{
  # home.packages = [ pkgs.editres ];

  xresources.properties = {
    "Editres*xt*namesLabel.Label" = "Normal Resources: right-click gets a value";
    "Editres*List.translations" = ''
      #override \n\
      <Btn3Down>,<Btn3Up>: Set() EnableGetVal() Notify()'';
  };
}
