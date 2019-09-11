#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
#PS1='[\u@\h \W]\$ '
PS1='\[\033[1;37m\]\u@\h \W \[\033[00m\]'
