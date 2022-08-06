#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias l='exa -l -a --icons --color=always --group-directories-first'
alias lg='l --grid'
alias ..='cd ..'
alias sps='sudo pacman -Syu'
alias switch-root='sudo /usr/bin/prime-switch'
alias hx=helix

PS1='\[\033[1;37m\]\u@\h \W \[\033[00m\]'
