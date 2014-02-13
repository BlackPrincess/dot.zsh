# users generic .zshrc file for zsh(1)
SCRIPT_DIR=".zsh"

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

## OSX tar

export COPYFILE_DISABLE=1

## Limit

limit coredumpsize 0

## Default shell configuration
#
# set prompt
#
autoload colors
colors
setopt prompt_subst

# ls_abbrev
. ${SCRIPT_DIR}/fn/ls_abbrev.sh

# show git-branch in rprompt
. ${SCRIPT_DIR}/fn/rprompt_git_current_branch.sh

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

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
# to end of it)
#

# import original functions
. ${SCRIPT_DIR}/bindkey/do_enter.sh 	# bindkey '^m' do_enter

bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N do_enter
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
bindkey '^m' do_enter



## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups		# ignore duplication command history list
setopt share_history		# share command history data

## Completion configuration
#
autoload -U compinit
compinit

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases # aliased ls needs if file/dir completions work



# default pager
if [ -x "`which lv`" ]; then
	export PAGER=lv
elif [ -x "`which jless`" ]; then
	export PAGER=jless
elif [ -x "`which less`" ]; then
	export PAGER=less
else
	export PAGER=more
fi

. $SCRIPT_DIR/alias.sh

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
	export TERM=xterm-color
	;;
kterm)
	export TERM=kterm-color
	# set BackSpace control character
	stty erase
	;;
cons25)
	unset LANG
	export LSCOLORS=ExFxCxdxBxegedabagacad
	export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
	zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'
	;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
	precmd() {
	    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
	}
	export LSCOLORS=exfxcxdxbxegedabagacad
	export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
	zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'
	;;
esac

## original settings
#
export BLOCKSIZE=K
export EDITOR=vi

. "${SCRIPT_DIR}/fn/screen.sh"

# reporttime
export REPORTTIME=5

if [[ -s /usr/local/bin/rbenv ]] ; then
	# rbenv
	eval "$(rbenv init - zsh)"
elif [[ -s $HOME/.rvm/scripts/rvm ]] ; then
	# rvm
	source $HOME/.rvm/scripts/rvm
fi

if which plenv > /dev/null; then eval "$(plenv init - zsh)"; fi

if [[ -d /usr/local/php ]]; then
	export PHP_VERSIONS=/usr/local/php
	source $(brew --prefix php-version)/php-version.sh
	php-version 5.3.20 > /dev/null
fi
