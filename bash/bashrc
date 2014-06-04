export PATH=/usr/local/bin:$PATH
# MySQL PATH variables
export PATH=$PATH:/usr/local/mysql/bin
# MySQL Libraries
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib
export PATH=$PATH:/Users/ryan/bin
# NPM binaries
export PATH=$PATH:/usr/local/share/npm/bin
# Virtualenv home
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
source /usr/local/bin/virtualenvwrapper.sh

# Don't edit default merge commit messages
export GIT_MERGE_AUTOEDIT=no

####################
# Terminal Behavior
####################
[ -f /Users/ryan/.shell_prompt.sh ] && source /Users/ryan/.shell_prompt.sh

export EDITOR="/usr/local/bin/vim -gf"
export CLICOLOR=1

# Aliases
alias tn="/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier -message \"Process has finished\""
alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"
alias tree="tree -I \*.pyc\|\*.un~\|\*.sw[op]\|\*node_modules\*\|%\*\|.DS_Store -Ca"
alias sp="python manage.py shell_plus --ipython"
alias rs="python manage.py runserver 0.0.0.0:8000"
alias git="hub"

# Functions
pman() {
    man -t $@ | open -f -a /Applications/Preview.app
}
psa() {
    ps $@ -o user,pid,ppid,cpu,start,tty,command 2>&1 | grep -v "grep\|YouCompleteMe\|Google Chrome.app"
}

###########
# Chef
###########
# Ruby binaries
export PATH=$PATH:/usr/local/opt/ruby/bin

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

rvm use 1.9.3 > /dev/null

###########
# Heroku
###########
export PATH="/usr/local/heroku/bin:$PATH"

########################
# ITerm2 Specific Config
########################
if [ -f "$HOME/.iterm_profiles" ]
then
    source "$HOME/.iterm_profiles"
fi
