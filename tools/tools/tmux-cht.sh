#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
selected=`cat $SCRIPT_DIR/.tmux-cht-languages $SCRIPT_DIR/.tmux-cht-commands | fzf`

read -p "Enter Query: " query

if grep -qs "$selected" $SCRIPT_DIR/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi
