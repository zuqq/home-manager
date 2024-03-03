{
  config,
  pkgs,
  alacritty-theme,
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

    pkgs.nodePackages.pyright
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

  programs.alacritty = {
    enable = true;
    settings = {
      # See: https://developer.apple.com/fonts/
      font = {
        bold = {
          family = "SF Mono";
          style = "Bold";
        };
        italic = {
          family = "SF Mono";
          style = "Italic";
        };
        normal = {
          family = "SF Mono";
          style = "Regular";
        };
        size = 13.0;
      };
      import = [alacritty-theme];
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-commentary

      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/telescope-nvim.lua;
      }

      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./nvim/nvim-treesitter.lua;
      }

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./nvim/nvim-lspconfig.lua;
      }

      which-key-nvim
    ];
    extraConfig = builtins.readFile ./.vimrc;
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./.zshrc;
  };
}
