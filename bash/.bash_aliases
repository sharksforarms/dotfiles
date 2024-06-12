# Custom commands
alias vim="nvim"
#alias nvim="/home/ethompson/src/neovim/build/bin/nvim"
alias editbashrc="vim ~/.bashrc"
alias editaliases="vim ~/.bash_aliases"
alias edithosts="sudo vim /etc/hosts"
alias editdns="sudo vim /etc/resolv.conf"
alias editvimrc="vim ~/.vimrc"
alias editi3="vim ~/.config/i3/config"
alias editx="vim ~/.Xdefaults"

#alias refreshbash="source ~/.bashrc"
alias refreshshell="xrdb ~/.Xdefaults && source ~/.zshrc"

alias cdzshplugins="cd ${ZSH_CUSTOM}/plugins"
alias mountshared="sudo mount -t vboxsf share ~/shared"
alias mountmusic="sudo mount -t vboxsf music ~/Music"
alias cctags="ctags --languages=C -R"
alias ccscope="find . -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.cxx' -o -name '*.hxx' > cscope.files; cscope -b"
alias cvim="cctags && ccscope && vim"
alias pvim="vim + -b -c\"set noeol\""
alias upper="tr '[:lower:]' '[:upper:]'"
alias lower="tr '[:upper:]' '[:lower:]'"
alias open='gnome-open'
alias path="readlink -f"
alias libgdb="libtool --mode=execute gdb"
alias libvalgrind="libtool --mode=execute valgrind"
alias prettyxml="xmllint --format"
alias prettyjson="python3 -m json.tool"
alias dnsflush="sudo /etc/init.d/nscd restart"
alias q="exit"
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
#alias make=colormake
alias clip="xclip -selection clipboard"
alias wmake="make CFLAGS='-Wall -Werror'"
alias diff=colordiff
alias "cd.."="cd .."
alias c="cd .."
alias search="grep -ri"
alias lsearch="grep -ril"
alias ff="find -name" # find file
alias strip-color="perl -pe 's/\x1b.*?[mGKH]//g'"
alias less="less -N"
alias gitlog="git log --pretty=oneline"
alias len="xargs echo -n | wc -c"
alias cargoupdate="cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ' | xargs -i cargo install --force {}"
alias scp_noreuse="scp -o \"ControlPath none\""

gch() {
    git checkout "$(git branch --all | fzf | tr -d '[:space:]')"
}

function debug_valgrind() {
    VALGRIND_PATH=$HOME/Downloads/valgrind/
    rm -f valg && VALGRIND_LIB=$VALGRIND_PATH/build/libexec/valgrind $VALGRIND_PATH/build/bin/valgrind --leak-check=full --log-file=valg $@
}

gitclean() {
    find . -name '*.orig' -delete
    find . -name '*BACKUP*' -delete
    find . -name '*REMOTE*' -delete
    find . -name '*BASE*' -delete
    find . -name '*LOCAL*' -delete
}

wssh() {
    pushd ~/misc-w/work_home/ > /dev/null
    ./transfer.sh --dotfiles $1
    popd  > /dev/null
    ssh $@
}
wwssh() {
    pushd ~/misc-w/work_home/ > /dev/null
    ./transfer.sh $1
    popd  > /dev/null
    ssh $@
}

function hl() {
    egrep --color "$1|"
}

# Add an "alert" alias for long running commands.  Use like so:
# #   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#  SETUP CONSTANTS
# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time24h="\t"
Time12a="\@"
PathShort="\W"
PathFull="\w"
NewLine="\n"
UserName="\u"
Host="\h"
Jobs="\j"

