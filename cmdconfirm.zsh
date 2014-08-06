#!/bin/zsh

#######################################
# cmdconfirm.zsh

# Adds a hook to zsh so that it will ask for confirmation if the command
# matches one of the regexes
#
# Usage:
#   1. Add "source cmdconfirm.zsh" to your .zshrc
#       a) If you use vi mode in zsh (bindkey -v), then you might
#       need to add to your .zshrc after 'bindkey -v':
#           bindkey '^J' cmd_confirm
#           bindkey '^M' cmd_confirm
#   2. Put your regexes here
REGEXES=(
"^git push"
"^any other command"
)
#######################################

function not_confirm {
    echo
    read -q "response?Are you sure? [y/N]"
    case $response in
        [yY][eE][sS]|[yY]) 
            false
            ;;
        *)
            true
            ;;
    esac
}

function matches_regex {
    for reg in $REGEXES; do
        if [[ $BUFFER =~ $reg ]]; then
            echo 1
            return
        fi
    done
    echo 0
}

function pre_command {
    if [[ $(matches_regex) -eq 1 ]]; then
        not_confirm && BUFFER=""
    fi

    zle accept-line
}

zle -N cmd_confirm pre_command

bindkey '^J' cmd_confirm
bindkey '^M' cmd_confirm
