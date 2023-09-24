{
  config,
  pkgs,
  pure,
  zsh-autosuggestions,
  zsh-z,
  ...
}: {
  home.username = "zuqq";
  home.homeDirectory = "/Users/zuqq";

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
    ".zshrc".source = ./.zshrc;
  };

  programs.home-manager.enable = true;

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-sensible

      vim-commentary
    ];
    extraConfig = builtins.readFile ./.vimrc;
    packageConfigurable = pkgs.vim-darwin;
  };
}
