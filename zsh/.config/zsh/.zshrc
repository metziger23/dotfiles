# history
HISTSIZE=110000
SAVEHIST=100000
HISTFILE=~/.histfile

# completion
zstyle :compinstall ~/.config/zsh/.zshrc

autoload -Uz compinit
compinit
