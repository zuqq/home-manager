{
  pkgs ?
    import <nixpkgs> {
      config.allowUnfree = true;
    },
}: {
  claude-code = pkgs.callPackage ./package.nix {};
}
