zmodload zsh/datetime
autoload -Uz add-zsh-hook

prompt_human_time () {
    local tmp=$1
    local days=$(( tmp / 60 / 60 / 24 ))
    local hours=$(( tmp / 60 / 60 % 24 ))
    local minutes=$(( tmp / 60 % 60 ))
    local seconds=$(( tmp % 60 ))
    (( $days > 0 )) && print -n "${days}d "
    (( $hours > 0 )) && print -n "${hours}h "
    (( $minutes > 0 )) && print -n "${minutes}m "
    print -n "${seconds}s"
}

prompt_cmd_exec_time () {
    local cmd_stop=$EPOCHSECONDS
    local cmd_start=${cmd_timestamp:-$cmd_stop}
    local elapsed=$(( cmd_stop - cmd_start ))
    prompt_human_time $elapsed
}

prompt_git_status () {
    local index="$(git status --porcelain -b 2> /dev/null)"
    local stat=""

    local added="$(echo "$index" | grep -c '^[AM]  ')"
    local modified="$(echo "$index" | grep -c '^ M \|^AM \|^ T ')"
    local renamed="$(echo "$index" | grep -c '^R  ')"
    local deleted="$(echo "$index" | grep -c '^ D \|^D  \|^AD ')"
    local unmerged="$(echo "$index" | grep -c '^UU ')"
    local untracked="$(echo "$index" | grep -c '^?? ')"

    [[ $unmerged -gt 0 ]] && stat=" ${unmerged}U$stat"
    [[ $untracked -gt 0 ]] && stat=" ${untracked}?$stat"
    [[ $deleted -gt 0 ]] && stat=" ${deleted}D$stat"
    [[ $renamed -gt 0 ]] && stat=" ${renamed}R$stat"
    [[ $modified -gt 0 ]] && stat=" ${modified}M$stat"
    [[ $added -gt 0 ]] && stat=" ${added}A$stat"

    print -n "$(echo $stat | sed -e 's/^ //')"
}

prompt_git_ahead_behind () {
    local ahead_behind=""

    set -- $(git rev-list --left-right --count @{upstream}...HEAD 2> /dev/null)
    [[ $1 -gt 0 ]] && ahead_behind=" $1↓$ahead_behind"
    [[ $2 -gt 0 ]] && ahead_behind=" $2↑$ahead_behind"

    print -n "$(echo $ahead_behind | sed -e 's/^ //')"
}

prompt_cwd () {
    local cwd="${PWD/$HOME/~}"
    local formatted_cwd=""
    local part_count=0
    local first_char=${cwd[1,1]/\//}

    while [[ $cwd == */* && $cwd != "/" ]]; do
        local part="${cwd:t}"
        cwd="${cwd:h}"

        formatted_cwd="/$part$formatted_cwd"
        part_count=$(( part_count + 1 ))

        if [[ $part_count -eq 3 && $cwd != "/" ]]; then
            formatted_cwd="...$formatted_cwd"
            break
        fi
    done
    print -n "$first_char$formatted_cwd"
}

prompt_virtual_env () {
    if [[ -n $VIRTUAL_ENV ]]; then
        print -n "%F{blue}(%F{yellow}${VIRTUAL_ENV:t}%F{blue})%f "
    fi
}

left_prompt_cmd () {
    local zero='%([BSUbfksu]|([FB]|){*})'

    prompt_msg="\n$(prompt_virtual_env)%F{green}%n@%m%f $(prompt_cwd) "

    prompt_msg_len=${#${(S%%)prompt_msg//$~zero/}}
    local fillsize=$(( COLUMNS - prompt_msg_len - 10 ))
    while (( $fillsize > 0 )); do
        prompt_msg="${prompt_msg}─"
        fillsize=$(( fillsize - 1 ))
    done
    print -n "$prompt_msg %*\n%B%(?.%F{blue}.%F{red})> %b%f"
}

right_prompt_cmd () {
    prompt_msg=""
    # Git branch
    branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    [[ -n $branch ]] && prompt_msg="%F{blue}(%F{yellow}$branch%F{blue})%f$prompt_msg"

    # Git status
    git_status="$(prompt_git_status)"
    [[ -n $git_status ]] && prompt_msg="%F{blue}(%F{red}$git_status%F{blue})%f$prompt_msg"

    # Git ahead/behind
    git_ahead_behind="$(prompt_git_ahead_behind)"
    [[ -n $git_ahead_behind ]] && prompt_msg="%F{blue}(%F{red}$git_ahead_behind%F{blue})%f$prompt_msg"

    # Exec time
    prompt_msg="%F{green}$(prompt_cmd_exec_time)%f $prompt_msg"

    print -n $prompt_msg
}

async_prompt_setup () {
    setopt prompt_subst

    PROMPT='$(left_prompt_cmd)'
    RPROMPT='$(right_prompt_cmd)'

    ASYNC_PROC=0

    prompt_precmd() {
        async() {
            # Save right prompt to tmp file
            printf "%s" "$(right_prompt_cmd)" > "${HOME}/.zsh_tmp_prompt"
            # Kill parent
            kill -s USR1 $$
        }

        # Kill child if necessary
        if [[ $ASYNC_PROC != 0 ]]; then
            kill -s HUP $ASYNC_PROC 2>&1 >> /dev/null || :
        fi

        # Start background
        async &!
        ASYNC_PROC=$!

        unset cmd_timestamp
    }

    TRAPUSR1() {
        # Read from tmp file
        RPROMPT="$(cat ${HOME}/.zsh_tmp_prompt)"
        # Reset proc number
        ASYNC_PROC=0
        # Redisplay
        zle && zle reset-prompt
    }


    add-zsh-hook precmd prompt_precmd
}

sync_prompt_setup () {
    prompt_precmd() {
        PROMPT="$(left_prompt_cmd)"
        RPROMPT="$(right_prompt_cmd)"

        unset cmd_timestamp
    }

    add-zsh-hook precmd prompt_precmd
}

prompt_preexec () {
    cmd_timestamp=$EPOCHSECONDS
}

prompt_setup () {
    if [[ $PROMPT_STYLE == "async" ]]; then
        async_prompt_setup
    else
        sync_prompt_setup
    fi

    add-zsh-hook preexec prompt_preexec
}

prompt_setup
