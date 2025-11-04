{ config, pkgs, lib, inputs, nixGL, ... }:
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
      # nix-prefetch-url --unpack "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz" 
      sha256 = "06w8vfga26ms84hdjjbqgjvs6gn7makkmpnas9yic4bi13ak50yb";
    }))
  ];
  nixGL = {
    packages = nixGL.packages; # you must set this or everything will be a noop
      defaultWrapper = "mesa"; # choose from nixGL options depending on GPU
  };  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mikhail";
  home.homeDirectory = "/home/mikhail";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # (config.lib.nixGL.wrap pkgs.hyprland)  
    # pkgs.rose-pine-cursor
    # pkgs.rose-pine-hyprcursor
    pkgs.playerctl
    pkgs.egl-wayland
    pkgs.hyprcursor
    pkgs.nwg-look
    pkgs.autotiling # for i3 wm
    (config.lib.nixGL.wrap pkgs.qtcreator)  
    pkgs.android-file-transfer
    pkgs.adbfs-rootless 
    pkgs.impala
    pkgs.just
    pkgs.rofi
    pkgs.bat
    pkgs.btop
    pkgs.fish
    pkgs.lazygit
    pkgs.fzf
    pkgs.zoxide
    pkgs.tealdeer
    pkgs.fd
    pkgs.ripgrep
    pkgs.delta
    pkgs.yazi
    pkgs.neovim  # This will be available thanks to the overlay 
    pkgs.neovim-remote
    pkgs.xkb-switch
    # pkgs.xkblayout-state 
    (config.lib.nixGL.wrap pkgs.qutebrowser) 
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mikhail/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {

    GIO_EXTRA_MODULES = "${pkgs.gvfs}/lib/gio/modules"; # NOTE: https://gist.github.com/Pablo1107/4afd86a7a5c086443a3a6dd07faa352d
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
  '';
  wayland.windowManager.hyprland = {
    systemd.variables = ["--all"];
    enable = true;
    package = config.lib.nixGL.wrap pkgs.hyprland;
    xwayland.enable = true;
    extraConfig = 
      ''
        source = ~/.config/hypr/workspaces.conf
        source = ~/.config/hypr/autostart.conf
        source = ~/.config/hypr/bindings.conf
        source = ~/.config/hypr/input.conf
        source = ~/.config/hypr/monitors.conf
        source = ~/.config/hypr/envs.conf
        source = ~/.config/hypr/looknfeel.conf
      ''; 
  }; 

  programs.fish = {
    plugins = [
    {
      name = "fzf.fish";
      src = pkgs.fetchFromGitHub {
        owner = "PatrickF1";
        repo = "fzf.fish";
        rev = "v10.3";
        sha256 = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
      };
    } 
    ];
  };
}
