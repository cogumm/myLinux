# meh. Dark Blood Rewind, a new beginning.

figlet CoGUMm
PROMPT=$'%{$fg[red]%}┌[ %{$fg_bold[white]%}%n%{$reset_color%}%{$fg[red]%}@%{$fg_bold[white]%}%m%{$reset_color%}%{$fg[red]%} ][%{$fg_bold[white]%} '%D{"%b %d %a, %H:%M"}%b$' %{$reset_color%}%{$fg[red]%}] ${return_status}$(git_prompt_info)$(git_prompt_status)%(?,,%{$fg[red]%}[%{$fg_bold[white]%}%?%{$reset_color%}%{$fg[red]%}])
%{$fg[red]%}└[%{$fg_bold[white]%}%~%{$reset_color%}%{$fg[red]%}]%{$reset_color%} '
PS2=$' %{$fg[red]%}|>%{$reset_color%} '

# git settings
# %{$(git_prompt_info)%}
ZSH_THEME_GIT_PROMPT_PREFIX="$fg[red][ %{$reset_color%}git:branch:"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$fg[red] ]%{$reset_color%}"

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}[%{$fg_bold[white]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[red]%}] "
#ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡%{$reset_color%}"
