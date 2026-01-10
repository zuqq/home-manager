{
  config,
  pkgs,
  pure,
  zsh-autosuggestions,
  zsh-z,
  ...
}: let
  claude-code = pkgs.callPackage ./pkgs/claude-code/package.nix {};
  codex = pkgs.callPackage ./pkgs/codex/package.nix {};
in {
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
    tree
    yq

    # Go
    go
    gofumpt
    golangci-lint
    golines
    gopls

    # Haskell
    cabal-install
    ghc
    haskell-language-server

    # Nix
    alejandra

    # Python
    pyright
    python312
    ruff
    uv

    claude-code
    codex
  ];
  home.file = {
    ".config/direnv/direnvrc".source = ./.config/direnv/direnvrc;
    ".editrc".source = ./.editrc;
    ".gitconfig".source = ./.gitconfig;
    ".gitignore".source = ./.gitignore;
    ".inputrc".source = ./.inputrc;
    ".ipython/profile_default/ipython_config.py".source = ./.ipython/profile_default/ipython_config.py;
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
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/which-key-nvim.lua;
      }
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
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile ./nvim/nvim-tree-lua.lua;
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
    ];
    extraConfig = builtins.readFile ./.vimrc;
  };
  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./.zshrc;
  };
}
