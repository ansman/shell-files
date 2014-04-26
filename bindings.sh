# Get vi like bindings for the terminal
export KEYTIMEOUT=1
bindkey -v
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^[OA" up-line-or-search
bindkey "^[OB" down-line-or-search
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search
