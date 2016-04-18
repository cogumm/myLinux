### ZSH Theme cgm.zsh-theme
### Vercion: 3.18.04.16
### by CoGUMm

# Personalização
PROMPT_AT=""
PROMPT_ADM="~>"
HOURS="{%b %d %a, %H:%M}"
FIGLET="CoGUMm"

# Colors
RESET="%{$reset_color%}"
RED="%{$fg[red]%}"
WHITE="%{$fg_bold[white]%}"
BLUE="%{$fg[blue]%}"
GREEN="%{$fg_bold[green]%}"

# Functions
function _my_name() {
  echo "$WHITE%n$RESET$RED"
}

function _my_hostname() {
  echo "$WHITE%m$RESET$RED"
}

function _my_hours() {
  echo "[$WHITE %D$HOURS%b $RESET$RED%}]"
}

function _my_git_status() {
  echo "${return_status}$(git_prompt_info)$(git_prompt_status)%(?,,'$RED'['$WHITE'%?$RESET'$RED'])"
}

function _my_home_folder() {
  echo "└[$WHITE %~ $RESET$RED]"
}

function _my_custom_prompt() {
  echo "$RED┌[ $(_my_name) $PROMPT_AT $(_my_hostname) ]$(_my_hours) $(_my_git_status)\n$RED$(_my_home_folder) $RESET"
}

# Configurações do GIT
# %{$(git_prompt_info)%}
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="[$YELLOW"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="$reset_color]"

ZSH_THEME_GIT_PROMPT_PREFIX="$reset_color("
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset_color)"

ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="$RED%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="$RED%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="$BLUE%{✚%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="$GREEN%{✔%G%}"

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT=$GREEN
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM=$YELLOW
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG=$RED
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL=$WHITE

# Prompt
# Como irá mostrar
### _____                          _       
###| ____|_  _____ _ __ ___  _ __ | | ___  
###|  _| \ \/ / _ \ '_ ` _ \| '_ \| |/ _ \ 
###| |___ >  <  __/ | | | | | |_) | | (_) |
###|_____/_/\_\___|_| |_| |_| .__/|_|\___/ 
###                                         
###┌[ USUÁRIO@HOSTNAME ][ DATA E HORA ] 
###└[ ~ ]

figlet $FIGLET
PROMPT=$'$(_my_custom_prompt)'
PS2=$' $RED$PROMPT_ADM$RESET '
