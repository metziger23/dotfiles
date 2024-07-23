if status is-interactive
    # Commands to run in interactive sessions can go here
  if test -d /opt/homebrew
    # Homebrew is installed on MacOS
    /opt/homebrew/bin/brew shellenv | source
  end

  abbr -a lg lazygit
  abbr -a n nvim

  set -x BAT_THEME "Catppuccin Mocha"
  set -x EDITOR nvim
  set -x VISUAL nvim
  set -x MANPAGER "nvim +Man!"

  fzf --fish | source # Set up fzf key bindings
  zoxide init fish | source
end
