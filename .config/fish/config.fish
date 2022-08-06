if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

alias l="exa -l -a --icons --color=always --group-directories-first"
alias lg="l --grid"
alias sps="sudo pacman -Syu"
alias hx=helix

zoxide init fish | source
