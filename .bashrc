## 
##  ~/.bashrc 
## 


export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PS1='\u@\h [\W]\$ '
export HISTCONTROL=ignoredups
export HISTSIZE=5000
export HISTFILESIZE=5000


export EDITOR="vim"

alias ll='ls -lhFA'
alias lld='ls -lh | grep ^d'
alias llf='ls -lh | grep -v ^d'
alias j='jobs'
alias free='free -h'
alias df='df -h'
alias vi='vim'


#case $TERM in
#    rxvt|rxvt-unicode|xterm|xterm-color|eterm|aterm|wterm*)
#        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"';
#        ;;
#    *)
#        ;;
#esac

if [ $TERM == "rxvt-unicode" ]; then export TERM=rxvt; fi 


lps1() {
    PS1='\u@\h [\w]\$ '
    export PS1
}

sps1() {
    PS1='\u@\h [\W]\$ '
    export PS1
}





