if status is-interactive
  fish_config prompt choose astronaut
  set -g fish_greeting
  set -U fish_prompt_pwd_dir_length 0
    # Commands to run in interactive sessions can go here
  if test -d /opt/homebrew
    # Homebrew is installed on MacOS
    /opt/homebrew/bin/brew shellenv | source
  end

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
end
