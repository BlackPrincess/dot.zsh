# ------------------------------
# Default shell configuration
# ------------------------------
#
# set prompt
#
autoload colors
colors
setopt prompt_subst

case ${UID} in
0)
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
  PROMPT="%B%{[36m%}[%n@%m]#%{[m%}%b "
  PROMPT2="%B%{[31m%}%_#%{[m%}%b "
  RPROMPT="%{[36m%}(`rprompt_git_current_branch`%{[36m%}%~%)%{[m%}"
  SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
*)
  PROMPT="%{[36m%}[%n@%m]%%%{[m%} "
  PROMPT2="%{[31m%}%_%%%{[m%} "
  RPROMPT='%{[36m%}(`rprompt_git_current_branch`%{[36m%}%~%)%{[m%}'
  SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

# reporttime
export REPORTTIME=5
