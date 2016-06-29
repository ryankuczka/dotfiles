# Changing/making/removing directory
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Basic directory operations
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias md='mkdir -p'

# Show history with timestamps mm/dd/yyyy
alias history='fc -fl 1'

# Common head/tail/grep/etc shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L='| less'
alias -g M='| more'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'

# Git
alias g='git'
compdef g=git
alias gd='git diff'
compdef _git gd=git-diff
alias gdc='git diff --cached'
compdef _git gdc=git-diff
alias gl='git pull'
compdef _git gl=git-pull
alias gup='git pull --rebase'
compdef _git gup=git-fetch
alias gp='git push'
compdef _git gp=git-push
alias gc='git commit'
compdef _git gc=git-commit
alias gc!='git commit --amend'
compdef _git gc!=git-commit
alias gca='git commit -a'
compdef _git gca=git-commit
alias gca!='git commit -a --amend'
compdef _git gca!=git-commit
alias gco='git checkout'
compdef _git gco=git-checkout
alias gcm='git checkout master'
alias gcd="git checkout develop"
alias gr='git remote'
compdef _git gr=git-remote
alias grbi='git rebase -i'
compdef _git grbi=git-rebase
alias grbc='git rebase --continue'
compdef _git grbc=git-rebase
alias grba='git rebase --abort'
compdef _git grba=git-rebase
alias gb='git branch'
compdef _git gb=git-branch
alias gba='git branch -a'
compdef _git gba=git-branch
alias ga='git add'
compdef _git ga=git-add
alias gm='git merge'
compdef _git gm=git-merge
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gsta='git stash'
alias gstl="git --no-pager stash list"
alias gsts='git stash show --text'
alias gstp='git stash pop'
alias gstd='git stash drop'
alias gss="git status -sb"
alias glg="git --no-pager log -n 25 --format=format:'%C(reset)%C(yellow)%h - %C(red)%ar%C(reset) %C(green)<%an> %C(reset)%s%C(bold yellow)%d'"
alias glgg="git log --format=format:'%C(reset)%C(yellow)%h - %C(red)%ar%C(reset) %C(green)<%an> %C(reset)%s%C(bold yellow)%d'"
alias gf="git fetch"

# Pretty Printing JSON
alias pp_json='python -mjson.tool'
if [[ $(whence node) != "" ]]; then
    alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
    alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
elif [[ $(whence python) != "" ]]; then
    alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
    alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
fi

# Web Searches
alias google='web_search google'
alias wiki='web_search duckduckgo \!w'
alias youtube='web_search duckduckgo \!yt'

# Misc
alias tree="tree -I '*.pyc|*.un~|*.sw[op]|*node_modules*|%*|.DS_Store|.git' -Ca"
