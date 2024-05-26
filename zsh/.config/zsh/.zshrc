# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

[ -f "${ZDOTDIR}/aliases.sh" ] && source "${ZDOTDIR}/aliases.sh"
[ -f "${ZDOTDIR}/history-config.sh" ] && source "${ZDOTDIR}/history-config.sh"
[ -f "${ZDOTDIR}/fzf-config.sh" ] && source "${ZDOTDIR}/fzf-config.sh"

# Completion styling
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
# remove fzf-tab-mappings and use default fzf mappings
zstyle ':fzf-tab:*' fzf-flags --bind "tab:toggle,btab:ignore,ctrl-space:ignore"

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
bindkey -s '\el' 'ls -l\n'                               # [Esc-l] - run command: ls
