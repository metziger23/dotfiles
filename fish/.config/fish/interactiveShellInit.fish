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
