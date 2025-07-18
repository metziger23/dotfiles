if status is-interactive
  fish_config prompt choose astronaut
  set -g fish_greeting
  set -g fish_prompt_pwd_dir_length 0
    # Commands to run in interactive sessions can go here
  if test -d /opt/homebrew
    # Homebrew is installed on MacOS
    /opt/homebrew/bin/brew shellenv | source
  end

  if test -d ~/.local/bin
    fish_add_path ~/.local/bin
  end

  set -l os (uname)
  if test "$os" = Darwin
    abbr -a shut sudo shutdown -h now
    # do things for macOS
  else if test "$os" = Linux
    # do things for Linux
  else
    # do things for other operating systems
  end

  abbr -a lg lazygit
  abbr -a n nvim

  set -x BAT_THEME "Catppuccin Mocha"
  set -x EDITOR nvim
  set -x VISUAL nvim
  set -x MANPAGER "nvim +Man!"

  zoxide init fish | source
end
