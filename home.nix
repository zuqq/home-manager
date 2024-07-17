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

    pkgs.pyright
    pkgs.python3
    pkgs.ruff

    pkgs.cabal-install
    pkgs.ghc
    pkgs.haskell-language-server
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

  programs.kitty = {
    enable = true;
    # See: https://developer.apple.com/fonts/
    font = {
      name = "SF Mono";
      size = 13.0;
    };
    keybindings =
      pkgs.lib.attrsets.mergeAttrsList
      (
        builtins.map
        (i: let s = builtins.toString i; in {"cmd+${s}" = "goto_tab ${s}";})
        (pkgs.lib.range 1 9)
      )
      // {"cmd+0" = "goto_tab 10";};
  };

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
