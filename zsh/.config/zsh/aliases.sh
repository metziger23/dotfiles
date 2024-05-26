
if (( $+commands[nvim] )); then
  alias n="nvim"
else
  print "nvim is not installed" >&2
  return 1
fi

if (( $+commands[lazygit] )); then
  alias lg="lazygit"
else
  print "lazygit is not installed" >&2
  return 1
fi

if (( $+commands[eza] )); then
  typeset -ag eza_params

  eza_params=(
    '--git' '--icons' '--group' '--group-directories-first'
    '--time-style=long-iso' '--color-scale=all'
  )

  alias ls='eza $eza_params'
  alias l='eza --git-ignore $eza_params'
  alias ll='eza --all --header --long $eza_params'
  alias llm='eza --all --header --long --sort=modified $eza_params'
  alias la='eza -lbhHigUmuSa'
  alias lx='eza -lbhHigUmuSa@'
  alias lt='eza --tree $eza_params'
  alias tree='eza --tree $eza_params'

else
  print "eza is not installed" >&2
  return 1
fi
