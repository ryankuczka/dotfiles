# The use_env call below is a reusable command to activate/create a new Python
# virtualenv, requiring only a single declarative line of code in your .env files.
# It only performs an action if the requested virtualenv is not the current one.
use_env() {
    typeset venv
    venv="$1"
    if [[ "${VIRTUAL_ENV:t}" != "$venv" ]]; then
        if workon | grep -q "$venv"; then
            workon "$venv"
        else
            echo -n "Create virtualenv $venv now? (Yn) "
            read answer
            if [[ "$answer" == "Y" ]]; then
                mkvirtualenv "$venv"
            fi
        fi
    fi
}

# Open man pages in Preview
pman() {
    man -t "$@" | open -f -a Preview
}

# Clean .pyc files
pyclean() {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
}

# Search from command line!
web_search() {
    local open_cmd
    if [[ $(uname -s) == "Darwin" ]]; then
        open_cmd='open'
    else
        open_cmd='xdg-open'
    fi

    if [[ ! $1 =~ '(google|bing|yahoo|duckduckgo)' ]]; then
        echo "Search engine $1 not supported."
        return 1
    fi

    local url="http://www.$1.com"
    if [[ $# -le 1 ]]; then
        $open_cmd "$url"
        return
    fi

    if [[ $1 == "duckduckgo" ]]; then
        url="${url}/?q="
    else
        url="${url}/search?q="
    fi
    shift

    while [[ $# -gt 0 ]]; do
        url="${url}$1+"
        shift
    done

    url="${url%?}"

    $open_cmd "$url"
}

# Reload zshrc
src() {
    autoload -U compinit zrecompile
    compinit -d "$DOTFILES_DIR/zsh/cache/zcomp-${HOST/.*/}"

    for f in $HOME/.zshrc "$DOTFILES_DIR/zsh/cache/zcomp-${HOST/.*/}"; do
        zrecompile -p $f && command rm -f $f.zwc.old
    done

    source $HOME/.zshrc
}

# Pip Completion Helpers
zsh-pip-clear-cache() {
    rm $DOTFILES_DIR/zsh/cache/pip
    unset piplist
}

zsh-pip-clean-packages() {
    sed -n '/<a href/ s/.*>\([^<]\{1,\}\).*/\1/p'
}

zsh-pip-cache-packages() {
    if [[ ! -d $DOTFILES_DIR/zsh/cache ]]; then
        mkdir -p $DOTFILES_DIR/zsh/cache
    fi

    if [[ ! -f $DOTFILES_DIR/zsh/cache/pip ]]; then
        echo -n "(...caching package index...)"
        tmp_cache=/tmp/zsh_tmp_cache
        curl 'https://pypi.python.org/simple/' 2>/dev/null | \
            zsh-pip-clean-packages >> $tmp_cache
        sort $tmp_cache | uniq | tr '\n' ' ' > $DOTFILES_DIR/zsh/cache/pip
        rm $tmp_cache
    fi
}

# Django Completion Helpers
zsh-django-clear-cache() {
    rm $DOTFILES_DIR/zsh/cache/django_*
    unset djangocommandlist
    unset djangoapplist
}

zsh-django-clean-commands() {
    sed -n '/^    [a-z]/ s/^    //p'
}

zsh-django-cache-commands() {
    if [[ ! -d $DOTFILES_DIR/zsh/cache ]]; then
        mkdir -p $DOTFILES_DIR/zsh/cache
    fi

    if [[ ! -f $DOTFILES_DIR/zsh/cache/django_commands ]]; then
        echo -n "(...caching django command index...)"
        tmp_cache=/tmp/zsh_tmp_cache
        python manage.py help 2>/dev/null | \
            zsh-django-clean-commands >> $tmp_cache
        sort $tmp_cache | uniq | tr '\n' ' ' > $DOTFILES_DIR/zsh/cache/django_commands
        rm $tmp_cache
    fi
}

zsh-django-cache-apps() {
    if [[ ! -d $DOTFILES_DIR/zsh/cache ]]; then
        mkdir -p $DOTFILES_DIR/zsh/cache
    fi

    if [[ ! -f $DOTFILES_DIR/zsh/cache/django_apps ]]; then
        echo -n "(...caching django app index...)"
        tmp_cache=/tmp/zsh_tmp_cache
        python -c "import re, django.conf, sys;[sys.stdout.write(re.sub(r'.*\.([a-z_]+)$', r'\1', i) + '\n') for i in django.conf.settings.INSTALLED_APPS]" >> $tmp_cache
        sort $tmp_cache | uniq | tr '\n' ' ' > $DOTFILES_DIR/zsh/cache/django_apps
        rm $tmp_cache
    fi
}

# Make man pages have color!
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# Terminal Notifier
tn() {
    if [[ ! -x /Applications/terminal-notifier.app/Conents/MacOS/terminal-notifer ]]; then
        echo "terminal-notifier is not installed!"
        return 1
    fi
    local message="Process has finished"
    if [[ $1 == "-message" ]]; then
        message=$2
        shift; shift;
    fi
    local prog=$1
    shift
    $prog $@
    /Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier -message "$message" -subtitle "$prog" > /dev/null
}

# Nice ps
psgrep() {
    local PSOUT="$(ps -o "user,pid,ppid,pcpu,pmem,start,etime,command" -e)"
    if [[ $# -eq 0 ]]; then
        echo $PSOUT
    else
        echo $PSOUT | head -n1
        echo $PSOUT | grep --color $@ | less -S
    fi
}
