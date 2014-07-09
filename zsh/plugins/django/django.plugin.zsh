zsh-django-clear-cache() {
    rm $ZSH_DJANGO_CACHE_FILE
    unset django_command_list
}

zsh-clean-django-command() {
    sed -E 's/ +/ /g' | sed -E "s/^'(.*'.*)'$/\"\1\"/"
}

zsh-django-cache-commands() {
    if [[ ! -d ${ZSH_DJANGO_CACHE_FILE:h} ]]; then
        mkdir -p ${ZSH_DJANGO_CACHE_FILE:h}
    fi

    if [[ ! -f $ZSH_DJANGO_CACHE_FILE ]]; then
        echo -n "(...caching django commands...)"
        local tmp_cache=/tmp/zsh_tmp_cache
        local python_path=~/.virtualenvs/ycharts/bin/python
        local manage_py=/sites/ycharts/manage.py
        for command in $($python_path $manage_py help | grep '^    [a-z]'); do
            print "'$command:$($python_path $manage_py help $command \
                | grep -v '^[ (Usage|Options)]\|^$' \
                | head -n1)'" | zsh-clean-django-command >> $tmp_cache
        done
        sort $tmp_cache | uniq | tr '\n' ' ' > $ZSH_DJANGO_CACHE_FILE
        rm $tmp_cache
    fi
}
