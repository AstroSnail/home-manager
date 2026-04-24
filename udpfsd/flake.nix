{
  description = "A UDPFS server written in Go";

  outputs =
    { self, nixpkgs }:

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      udpfsd = pkgs.callPackage self { };

    in
    {
      packages.${system} = {
        inherit udpfsd;
        default = udpfsd;
      };
    };
}
