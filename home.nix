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
  home.packages = with pkgs; [
    bash
    curl
    fd
    fzf
    gh
    git
    hyperfine
    jq
    lazygit
    ripgrep
    tmux
    yq

    # Go
    go
    gofumpt
    golangci-lint
    gopls

    # Haskell
    cabal-install
    ghc
    haskell-language-server

    # Nix
    alejandra

    # Python
    pyright
    python3
    ruff
    uv

    claude-code
  ];
  home.file = {
    ".config/direnv/direnvrc".source = ./.config/direnv/direnvrc;
    ".editrc".source = ./.editrc;
    ".gitconfig".source = ./.gitconfig;
    ".gitignore".source = ./.gitignore;
    ".inputrc".source = ./.inputrc;
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
      {
        plugin = blink-cmp;
        type = "lua";
        config = builtins.readFile ./nvim/blink-cmp.lua;
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./nvim/nvim-lspconfig.lua;
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./nvim/nvim-treesitter.lua;
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/telescope-nvim.lua;
      }
      vim-commentary

      (which-key-nvim.overrideAttrs {
        # The next version was 3.0.0, which contained the commit that switched
        # from `register` to `add`:
        #
        #     https://github.com/folke/which-key.nvim/commit/41374bcae462d897fa98c904a44127e258c0438c.
        version = "2.1.0";
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "which-key.nvim";
          rev = "0539da005b98b02cf730c1d9da82b8e8edb1c2d2";
          sha256 = "sha256-gc/WJJ1s4s+hh8Mx8MTDg8pGGNOXxgKqBMwudJtpO4Y=";
        };
      })
    ];
    extraConfig = builtins.readFile ./.vimrc;
  };
  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./.zshrc;
  };
}
