{
  pkgs ?
    import <nixpkgs> {
      config.allowUnfree = true;
    },
}: {
  codex = pkgs.callPackage ./package.nix {};
}
