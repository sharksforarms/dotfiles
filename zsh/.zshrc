export ZSH=$HOME/.oh-my-zsh
TERM=xterm-256color

export EDITOR="nvim"
export VISUAL="nvim"

ZSH_THEME="robbyrussell-custom"

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

plugins=(
  fzf
  git
  vi-mode

  zsh-autosuggestions
  fast-syntax-highlighting
  nice-exit-code
  zsh-z
)
source $ZSH/oh-my-zsh.sh

bindkey "^[Od" backward-word
bindkey "^[Oc" forward-word
bindkey '^ ' autosuggest-accept
# Ctrl+V to get current command in editor
bindkey -M vicmd "^V" edit-command-line

# Alias
source ~/.bash_aliases

export MANPAGER='nvim --appimage-extract-and-run +Man!'
export MANWIDTH=999

# Virtualenv setup
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=~/.virtualenvs
source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh

source ~/.cargo/env

autoload -U select-word-style
select-word-style bash

export PATH=$PATH:$HOME/tools/
export PATH=$PATH:$HOME/tools-w/
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin/
export PATH=$PATH:$HOME/.local/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
