# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Use emacs key bindings
bindkey -e

# Ctrl-R - Search backward
bindkey '^r' history-incremental-search-backward

# Shift-Tab - Move through completion menu backwards
if [[ "${terminfo[kcbt]}" != "" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

# OS X Delete like Backspace
bindkey '^?' backward-delete-char
# Normal Delete behavior
if [[ "${terminfo[kdch1]}" != "" ]]; then
    bindkey "${terminfo[kdch1]}" delete-char
else
    bindkey "^[[3~" delete-char
    bindkey "^[3;5~" delete-char
    bindkey "\e[3~" delete-char
fi

# Edit current command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Esc-M to copy previous word (file renaming magics!)
bindkey "^[m" copy-prev-shell-word
