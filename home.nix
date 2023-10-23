{
  config,
  pkgs,
  pure,
  zsh-autosuggestions,
  zsh-z,
  ...
}: {
  home.username = "noah";
  home.homeDirectory = "/Users/noah";

  home.stateVersion = "23.05";

  home.packages = [
    pkgs.bash
    pkgs.curl
    pkgs.fd
    pkgs.git
    pkgs.hyperfine
    pkgs.jq
    pkgs.ripgrep
    pkgs.tmux
    pkgs.yq
  ];

  home.file = {
    ".editrc".source = ./.editrc;

    ".inputrc".source = ./.inputrc;

    ".gitconfig".source = ./.gitconfig;
    ".gitignore".source = ./.gitignore;

    ".tmux.conf".source = ./.tmux.conf;

    ".zsh/pure".source = pure;
    ".zsh/zsh-autosuggestions".source = zsh-autosuggestions;
    ".zsh/zsh-z".source = zsh-z;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.home-manager.enable = true;

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-commentary
    ];
    extraConfig = builtins.readFile ./.vimrc;
    packageConfigurable = pkgs.vim-darwin;
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./.zshrc;
  };
}
