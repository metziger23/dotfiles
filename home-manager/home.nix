{
  config,
  pkgs,
  lib,
  ...
}: let
  btopColorTheme = "catppuccin_black";
  nvimConfigDir = "${config.home.homeDirectory}/.dotfiles/nvim/.config/nvim";
  fishConfigDir = "${config.home.homeDirectory}/.dotfiles/fish/.config/fish";
in {
  home.username = "mikhail";
  home.homeDirectory = "/home/mikhail";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    just-lsp
    just
    process-compose
    devenv
    cheese
    host-spawn
    ghostty
    zenity
    hyprpaper
    satty
    hyprshot
    fish
    fishPlugins.fzf-fish
    stylua
    qt6.qtdeclarative
    fish-lsp
    bash-language-server
    lua-language-server
    clang-tools
    neovim
    bear
    btop
    gnumake
    jq
    nil
    nixd
    alejandra
    nodejs
    python3
    unzip
    stow
    tree
    git
    git-lfs
    delta
    tree-sitter
    zoxide
    fzf
    bat
    lazygit
    neovim-remote
    ripgrep
    fd
    ttyper
    cliphist
    wl-clipboard
    gcc
  ];

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink nvimConfigDir;
    recursive = true;
  };

  xdg.configFile."btop/themes/${btopColorTheme}.theme".source =
    ./btop/themes/${btopColorTheme}.theme;

  programs.btop = {
    enable = true;

    settings = {
      vim_keys = true;

      color_theme = "${btopColorTheme}.theme";
      theme_background = "${btopColorTheme}.theme";
    };
  };

  programs.zoxide.enable = true;

  xdg.configFile."fish" = {
    source = config.lib.file.mkOutOfStoreSymlink fishConfigDir;
    recursive = true;
  };

  programs.home-manager.enable = true;
}
