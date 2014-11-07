#!/bin/bash
#
# Works with both bash and zsh
#
# https://github.com/seanyeh/misc-scripts
# run "cd_aliases.sh help" for help


# Put your aliases here in the form of "alias:fullpath"
CD_ALIASES=(
"mydir:/full/path/to/my/dir"
"anotherdir:/why/is/this/path/so/extremely/long"
)

_CD_ALIASES_lookup() {
    len=${#1}
    for item in "${CD_ALIASES[@]}"; do
        if [ "$1:" = "${item:0:$len+1}" ]; then
            first_arg="${item:$len+1}"
            return 0
        fi
    done

    return 1
}


if [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ "$1" = "help" ]; then
    printf "cd_aliased.sh - easy aliases for cd

\t--help, -h, help\tPrint this help message
\t--list, -l, list\tList available aliases

Edit the \"CD_ALIASES\" array in this script to add your own directory aliases.
Each item should be in the form \"mydir:/full/path/of/my/dir\".

It's recommended to add a shell alias to 'source cd_aliased.sh', such as
adding to your .bashrc or .zshrc:
\talias c='source cd_aliased.sh'

This way, you can simply call 'c mydir' to reach \"/full/path/of/my/dir\"
\n"

elif [ "$1" = "--list" ] || [ "$1" = "-l" ] || [ "$1" = "list" ]; then
    printf "Here are the available aliases in the form of alias:fullpath pairs\n"
    for item in "${CD_ALIASES[@]}"; do
        printf "\t$item\n"
    done

else
    first_arg="$1"

    # Remove the "&& echo ..." if you don't want anything to be printed
    _CD_ALIASES_lookup "$first_arg" && echo "$1 aliased to: $first_arg"

    shift
    cd "$first_arg" "$@"
fi
