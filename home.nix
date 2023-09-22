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
    git
    hyperfine
    jq
    ripgrep
    tmux
    yq

    # Python
    pyright
    python3
  ];
  home.file = {
    ".editrc".source = ./.editrc;
    ".gitconfig".source = ./.gitconfig;
    ".gitignore".source = ./.gitignore;
    ".inputrc".source = ./.inputrc;
    ".tmux.conf".source = ./.tmux.conf;
    ".zsh/pure".source = pure;
    ".zsh/zsh-autosuggestions".source = zsh-autosuggestions;
    ".zsh/zsh-z".source = zsh-z;
    ".zshrc".source = ./.zshrc;
  };
  programs.home-manager.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
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
      which-key-nvim
    ];
    extraConfig = builtins.readFile ./.vimrc;
  };
}
