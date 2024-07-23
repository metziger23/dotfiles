if status is-interactive
    # Commands to run in interactive sessions can go here
  if test -d /opt/homebrew
    # Homebrew is installed on MacOS
    /opt/homebrew/bin/brew shellenv | source
  end

  fzf --fish | source # Set up fzf key bindings
  zoxide init fish | source
end
