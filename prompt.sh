h=$(hostname | grep -o "^[^.]\+" | tr "[A-Z]" "[a-z]")
# PROMPT='%{$fg[$NCOLOR]%}%B%n@$h%b%{$reset_color%}:%{$fg[blue]%}%B%c/%b%{$reset_color%} $(git_prompt_info)%(!.#.$) '
PROMPT='
%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) ☃ $h ☃ %{$fg_bold[red]%}%*%{$reset_color%}
$ '
