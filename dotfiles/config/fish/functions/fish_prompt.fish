function fish_prompt --description 'Write out the prompt'
	if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

		# Fish git prompt
		set -g __fish_git_prompt_show_informative_status 1
		set -g __fish_git_prompt_hide_untrackedfiles 1

		# set -g __fish_git_prompt_color_branch magenta bold
		set -g __fish_git_prompt_showupstream "informative"
		set -g __fish_git_prompt_char_upstream_ahead "↑"
		set -g __fish_git_prompt_char_upstream_behind "↓"
		set -g __fish_git_prompt_char_upstream_prefix ""

		# Status Chars
		set -g __fish_git_prompt_char_stagedstate "●"
		set -g __fish_git_prompt_char_dirtystate "*"
		set -g __fish_git_prompt_char_untrackedfiles "?"
		set -g __fish_git_prompt_char_conflictedstate "#"
		set -g __fish_git_prompt_char_cleanstate "✔"

		set -g __fish_git_prompt_color_dirtystate blue
		set -g __fish_git_prompt_color_stagedstate yellow
		set -g __fish_git_prompt_color_invalidstate red
		set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
		# set -g __fish_git_prompt_color_cleanstate green bold

    echo -n -s " " (set_color cyan) "λ" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" ' '
    set_color normal
    # echo -n -s "$USER" @ (prompt_hostname) ' ' "$__fish_prompt_cwd" (prompt_pwd) (__fish_vcs_prompt) "$__fish_prompt_normal" '> '
end



    # /*# Fish git prompt*/
    # /*set __fish_git_prompt_showdirtystate 'yes'*/
    # /*set __fish_git_prompt_showstashstate 'yes'*/
    # /*set __fish_git_prompt_showuntrackedfiles 'yes'*/
    # /*set __fish_git_prompt_showupstream 'yes'*/
    # /*set __fish_git_prompt_color_branch yellow*/
    # /*set __fish_git_prompt_color_upstream_ahead green*/
    # /*set __fish_git_prompt_color_upstream_behind red*/

    # /*# Status Chars*/
    # /*set __fish_git_prompt_char_dirtystate '⚡'*/
    # /*set __fish_git_prompt_char_stagedstate '→'*/
    # /*set __fish_git_prompt_char_untrackedfiles '☡'*/
    # /*set __fish_git_prompt_char_stashstate '↩'*/
    # /*set __fish_git_prompt_char_upstream_ahead '+'*/
    # /*set __fish_git_prompt_char_upstream_behind '-'*/
