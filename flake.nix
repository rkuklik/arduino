{
  description = "Arduino development";

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      pkgsFor = system: nixpkgs.legacyPackages.${system};
      x86_64 = "x86_64-linux";
      aarch64 = "aarch64-linux";
    in
    {
      devShells = {
        ${x86_64}.default = import ./shell.nix { pkgs = pkgsFor x86_64; };
        ${aarch64}.default = import ./shell.nix { pkgs = pkgsFor aarch64; };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
  };
}
