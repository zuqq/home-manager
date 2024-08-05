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
    pkgs.alejandra

    pkgs.bash
    pkgs.curl
    pkgs.fd
    pkgs.git
    pkgs.hyperfine
    pkgs.jq
    pkgs.ripgrep
    pkgs.tmux
    pkgs.yq

    pkgs.go
    pkgs.gofumpt
    pkgs.golangci-lint
    pkgs.gopls

    pkgs.cabal-install
    pkgs.ghc
    pkgs.haskell-language-server

    pkgs.pyright
    pkgs.python3
    pkgs.ruff

    pkgs.cargo
    pkgs.rust-analyzer
    pkgs.rustc
  ];

  home.file = {
    ".config/kitty/kitty.conf".text = ''
      # See: https://developer.apple.com/fonts/
      font_family SF Mono
      font_size 13.0

      include ${pkgs.kitty-themes}/share/kitty-themes/themes/tokyo_night_night.conf

      map cmd+0 goto_tab 10
      map cmd+1 goto_tab 1
      map cmd+2 goto_tab 2
      map cmd+3 goto_tab 3
      map cmd+4 goto_tab 4
      map cmd+5 goto_tab 5
      map cmd+6 goto_tab 6
      map cmd+7 goto_tab 7
      map cmd+8 goto_tab 8
      map cmd+9 goto_tab 9

      shell_integration no-rc
    '';

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

      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/tokyonight-nvim.lua;
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
