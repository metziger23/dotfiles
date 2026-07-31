if test -d ~/.local/bin
  fish_add_path ~/.local/bin
end

if status is-interactive
  fish_config prompt choose astronaut
  functions --copy fish_prompt original_fish_prompt

  function fish_prompt
    if test -n "$CONTAINER_ID"
      set_color yellow
      echo -n "[$CONTAINER_ID] "
    end

    set_color normal
    original_fish_prompt
  end

  set -g fish_greeting
  set -g fish_prompt_pwd_dir_length 0

  abbr -a lg lazygit
  abbr -a n nvim
  abbr -a j just

  set -x BAT_THEME "Catppuccin Mocha"
  set -x EDITOR nvim
  set -x VISUAL nvim
  set -x MANPAGER "nvim +Man!"

  zoxide init fish | source
end
