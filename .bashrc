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
alias switch='optimus-manager --switch auto'
alias mode='optimus-manager --status'

#PS1='[\u@\h \W]\$ '
PS1='\[\033[1;37m\]\u@\h \W \[\033[00m\]'
