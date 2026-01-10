{
  pkgs ? import <nixpkgs> {},
}: {
  pi-coding-agent = pkgs.callPackage ./package.nix {};
}
