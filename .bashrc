#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias l='ls -l'
alias ranger='source ranger'
alias ff='firefox'
alias ..='cd ..'
alias sps='sudo pacman -Syu'
alias switch1='optimus-manager --switch auto'
alias switch2='sudo /usr/bin/prime-switch'
alias mode='optimus-manager --status'

#LS_COLORS=$LS_COLORS:'di=1;34:ln=0;34'
#export LS_COLORS

#PS1='[\u@\h \W]\$ '
PS1='\[\033[1;37m\]\u@\h \W \[\033[00m\]'
