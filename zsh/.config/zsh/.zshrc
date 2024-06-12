if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
  zinit light starship/starship

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit snippet https://github.com/junegunn/fzf-git.sh/blob/main/fzf-git.sh
zinit light Aloxaf/fzf-tab
zinit snippet OMZP::fzf
zinit snippet OMZP::git

[ -f "${ZDOTDIR}/aliases.sh" ] && source "${ZDOTDIR}/aliases.sh"
[ -f "${ZDOTDIR}/history-config.sh" ] && source "${ZDOTDIR}/history-config.sh"
[ -f "${ZDOTDIR}/fzf-config.sh" ] && source "${ZDOTDIR}/fzf-config.sh"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # set list-colors to enable filename colorizing
zstyle ':completion:*' menu no # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':fzf-tab:*' fzf-flags --bind "tab:toggle+down,btab:toggle+up,ctrl-space:ignore,bspace:backward-delete-char,ctrl-h:backward-delete-char"

# ----- Bat (better cat) -----
export BAT_THEME="Catppuccin Mocha"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# use neovim as a default editor
export EDITOR=nvim
VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

### "nvim" as manpager
export MANPAGER="nvim +Man!"

export PATH="$HOME/.local/bin":$PATH
eval "$(zoxide init zsh)"
bindkey -s '\el' 'll -l\n'                               

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

