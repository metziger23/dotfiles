{
  config,
  pkgs,
  lib,
  ...
}: let
  btopColorTheme = "catppuccin_black";
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  names = [
    "btop/themes/${btopColorTheme}.theme"
    "dunst"
    "fish"
    "hypr"
    "kitty"
    "lazygit"
    "nvim"
    "quickshell"
    "rofi"
  ];
  configs = lib.genAttrs names (n: n);
in {
  xdg.configFile =
    builtins.mapAttrs
    (name: subpath: {
      source = createSymlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  programs.btop = {
    enable = true;

    settings = {
      vim_keys = true;

      color_theme = "${btopColorTheme}.theme";
      theme_background = "${btopColorTheme}.theme";
    };
  };

  programs.zoxide.enable = true;

  programs.git = {
    enable = true;
    includes = [
      {path = "${config.home.homeDirectory}/.config/git/private";}
    ];
    settings = {
      core = {
        pager = "delta";
        editor = "nvim -c 'startinsert'";
      };

      commit.verbose = true;

      interactive.diffFilter = "delta --color-only";

      delta = {
        navigate = true;
        dark = true;
      };

      merge.conflictstyle = "zdiff3";
      diff.colorMoved = "default";

      credential.helper = "store";
    };
  };

  programs.home-manager.enable = true;

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
}
