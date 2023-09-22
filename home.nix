{ config, pkgs, ... }: {
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

    ".zsh" = {
      source = ./.zsh;
      recursive = true;
    };
    ".zshrc".source = ./.zshrc;
  };

  programs.home-manager.enable = true;

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-sensible

      vim-commentary
    ];
    extraConfig = ''
      set autoindent
      set smartindent

      set expandtab
      set shiftwidth=4
      set softtabstop=4

      set hlsearch
      set ignorecase
      set smartcase

      set splitbelow
      set splitright

      noremap j gj
      noremap k gk

      set clipboard=unnamed

      set nojoinspaces
    '';
    packageConfigurable = pkgs.vim-darwin;
  };
}
