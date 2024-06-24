if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

alias l="exa -l -a --icons --color=always --group-directories-first"
alias integrated="sudo envycontrol --switch integrated; reboot"
alias hybrid="sudo envycontrol --switch hybrid; reboot"

zoxide init fish | source

fish_add_path ~/.local/bin
