# Defined in - @ line 2
function ls
	set_color red
    echo "Remember to use exa"
    set_color normal
    command ls $argv
end
