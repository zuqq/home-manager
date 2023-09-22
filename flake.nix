{
  description = "home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pure = {
      url = "github:sindresorhus/pure";
      flake = false;
    };

    zsh-autosuggestions = {
      url = "github:zsh-users/zsh-autosuggestions";
      flake = false;
    };

    zsh-z = {
      url = "github:agkozak/zsh-z";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    pure,
    zsh-autosuggestions,
    zsh-z,
    ...
  }: {
    homeConfigurations.noah = home-manager.lib.homeManagerConfiguration {
      modules = [./home.nix];
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      extraSpecialArgs = {
        inherit pure zsh-autosuggestions zsh-z;
      };
    };
  };
}
