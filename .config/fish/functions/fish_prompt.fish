function fish_prompt
    set_color --bold
    
    echo -n $USER@$hostname
     
    echo -n " "
    
    set -l color $fish_color_cwd
    set_color $color
    echo -n (prompt_pwd)
    
    echo -n " "
    
    set_color normal

end
