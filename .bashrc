#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ..='cd ..'
alias l='exa -l -a --icons --color=always --group-directories-first'
alias lg='l --grid'
alias hx=helix

eval "$(zoxide init bash)"

PS1='\[\033[1;37m\]\u@\h \W \[\033[00m\]'
