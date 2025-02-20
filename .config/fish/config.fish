if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

alias l="exa -l -a --icons --color=always --group-directories-first"
alias integrated="sudo envycontrol --switch integrated; reboot"
alias hybrid="sudo envycontrol --switch hybrid; reboot"
alias n="nvim"

set -gx EDITOR nvim

zoxide init fish | source

fish_add_path ~/.local/bin

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
