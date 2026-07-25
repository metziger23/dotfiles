{
  config,
  pkgs,
  ...
}: let
  btop_color_theme = "catppuccin_black";
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

  programs.btop = {
    enable = true;

    settings = {
      vim_keys = true;

      color_theme = "${btop_color_theme}.theme";
      theme_background = "${btop_color_theme}.theme";
    };
  };

  xdg.configFile."btop/themes/${btop_color_theme}.theme".source =
    ./btop/themes/${btop_color_theme}.theme;

  programs.zoxide.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      function __in_podman_container --description 'Return 0 if inside a podman container'
        test -f /run/.containerenv
      end

      function __podman_container_name --description 'Print container name if available'
        if test -f /run/.containerenv
          string match -r '^name="([^"]+)"$' < /run/.containerenv \
            | string replace -r '^name="([^"]+)"$' '$1'
        end
      end

      fish_config prompt choose astronaut
      set -g fish_greeting
      set -g fish_prompt_pwd_dir_length 0

      # --- add container indicator to prompt (must be AFTER choosing prompt) ---
      if not functions -q fish_prompt_orig
        functions -c fish_prompt fish_prompt_orig 2>/dev/null
      end

      function fish_prompt
        if __in_podman_container
          set -l cn (__podman_container_name)

          set_color yellow
          if test -n "$cn"
            echo -n "[$cn] "
          else
            echo -n "[ctr] "
          end
          set_color normal
        end

        fish_prompt_orig
      end
      # -----------------------------------------------------------------------

      if test -d ~/.local/bin
        fish_add_path ~/.local/bin
      end

      abbr -a lg lazygit
      abbr -a n nvim

      set -x BAT_THEME "Catppuccin Mocha"
      set -x EDITOR nvim
      set -x VISUAL nvim
      set -x MANPAGER "nvim +Man!"

      zoxide init fish | source

      ## --- fzf.fish: force keybindings (use --user to override presets) ---
      #if status is-interactive
      #  bind --user \e\cf _fzf_search_directory
      #  bind --user \e\cl _fzf_search_git_log
      #  bind --user \e\cs _fzf_search_git_status
      #  bind --user \e\cp _fzf_search_processes
      #  bind --user \cr _fzf_search_history
      #  bind --user \cv _fzf_search_variables
      #end
      # ----------------------------------------------------------------------
    '';
  };

  programs.home-manager.enable = true;
}
