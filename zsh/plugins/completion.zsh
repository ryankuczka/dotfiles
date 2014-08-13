unsetopt menu_complete  # don't autoselect first completion entry
unsetopt flowcontrol
setopt auto_menu        # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

WORDCHARS=''

zmodload -i zsh/complist

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# Disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# Use caching so that commands are usable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $DOTFILES_DIR/cache/
