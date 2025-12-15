{
  description = "home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      extraSpecialArgs = {
        inherit pure zsh-autosuggestions zsh-z;
      };
    };
  };
}
