cwd_prompt () {
    local cwd="${PWD/$HOME/~}"
    local formatted_cwd=""
    local part_count=0
    local first_char=$cwd[1,1]

    while [[ $cwd == */* && $cwd != "/" ]]; do
        local part="${cwd:t}"
        cwd="${cwd:h}"

        formatted_cwd=" $part $formatted_cwd"
        part_count=$(( part_count + 1 ))

        [[ $part_count -eq 3 ]] && formatted_cwd="⋯ $formatted_cwd" && break
    done

    print -n "$first_char $formatted_cwd"
}

git_status_prompt () {
    local index="$(git status --porcelain -b 2> /dev/null)"
    local stat=""
    local suffix=""

    local added="$(echo "$index" | grep -c '^[AM]  ')"
    local modified="$(echo "$index" | grep -c '^ M \|^AM \|^ T ')"
    local renamed="$(echo "$index" | grep -c '^R  ')"
    local deleted="$(echo "$index" | grep -c '^ D \|^D  \|^AD ')"
    local unmerged="$(echo "$index" | grep -c '^UU ')"

    [[ $added -gt 0 ]] && stat=" ${added}A$stat"
    [[ $modified -gt 0 ]] && stat=" ${modified}M$stat"
    [[ $renamed -gt 0 ]] && stat=" ${renamed}R$stat"
    [[ $deleted -gt 0 ]] && stat=" ${deleted}D$stat"
    [[ $unmerged -gt 0 ]] && stat=" ${unmerged}U$stat"

    print -n "$stat"
}

git_ahead_behind_prompt () {
    ahead_behind=""

    set -- $(git rev-list --left-right --count @{upstream}...HEAD 2> /dev/null)
    local behind_count=$1
    local ahead_count=$2
    [[ $behind_count -gt 0 ]] && ahead_behind=" ${behind_count}↓$ahead_behind"
    [[ $ahead_count -gt 0 ]] && ahead_behind=" ${ahead_count}↑$ahead_behind"

    print -n "$ahead_behind"
}

left_prompt () {
    local sep=""
    local sep_alt=""

    if [[ -n $VIRTUAL_ENV ]]; then
        print -n "$BG[$ZSH_PROMPT_BG_A]$FG[$ZSH_PROMPT_FG_A]$FX[bold] ${VIRTUAL_ENV:t} $FX[reset]$FG[$ZSH_PROMPT_BG_A]$BG[$ZSH_PROMPT_BG_B]$sep "
    else
        print -n "$BG[$ZSH_PROMPT_BG_B] "
    fi

    print -n "$FG[$ZSH_PROMPT_FG_B]$(print %n) $sep_alt $(print %m) $FG[$ZSH_PROMPT_BG_B]$BG[$ZSH_PROMPT_BG_C]$sep "

    print -n "$FG[$ZSH_PROMPT_FG_C]$(cwd_prompt)"

    print -n "$FX[reset]$FG[$ZSH_PROMPT_BG_C]$sep$FX[reset] "
}

right_prompt () {
    local sep=""
    local sep_alt=""

    if [[ $last_exit_code -gt 0 ]]; then
        print -n "$FG[$ZSH_PROMPT_BG_A]$sep$FG[$ZSH_PROMPT_FG_A]$BG[$ZSH_PROMPT_BG_A] $last_exit_code "
    fi

    local branch="$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null )"
    if [[ -n $branch ]]; then
        print -n "$FG[$ZSH_PROMPT_BG_B]$sep$FG[$ZSH_PROMPT_FG_B]$BG[$ZSH_PROMPT_BG_B]  ${branch:t} "
    fi

    local next_prefix="$FG[$ZSH_PROMPT_BG_C]$sep$FG[$ZSH_PROMPT_FG_C]$BG[$ZSH_PROMPT_BG_C]"

    local ahead_behind="$(git_ahead_behind_prompt)"
    if [[ -n $ahead_behind ]] && [[ -z $gstat ]]; then
        print -n "$next_prefix$ahead_behind "
        next_prefix="$sep_alt"
    fi

    local gstat="$(git_status_prompt)"
    if [[ -n $gstat ]]; then
        print -n "$next_prefix$gstat "
        next_prefix="$sep_alt"
    fi

    if [[ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]]; then
        print -n "$next_prefix + "
    fi

    print -n "$FX[reset]"
}

update_prompt () {
    local last_exit_code="$?"
    PROMPT="$(left_prompt)"
    RPROMPT="$(right_prompt)"
}

if [[ ! ${precmd_functions[(r)update_prompt]} == update_prompt ]]; then
    precmd_functions+=(update_prompt)
fi
