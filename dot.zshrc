# users generic .zshrc file for zsh(1)

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

function ls_abbrev() {
	# -a : Do not ignore entries starting with ..
	# -C : Force multi-column output
	# -F : Append indicator one of */=>@|) to entries.
	local cmd_ls='ls'
	local -a opt_ls
	opt_ls=('-aCF' '--color=always')
	case "${OSTYPE}" in
		freebsd*|darwin*)
			if type gls > /dev/null 2>&1; then
				cmd_ls='gls'
			else
				# -G : Enable colorized output.
				opt_ls=('-aCFG')
			fi
			;;
	esac

	local ls_result
	ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

	local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

	if [ $ls_lines -gt 10 ]; then
		echo "$ls_result" | head -n 5
		echo '...'
		echo "$ls_result" | tail -n 5
		echo "$(command ls -l -A | wc -l | tr -d ' ') files exist"
	else
		echo "$ls_result"
	fi
}

# execute ls(1) by enter

function do_enter() {
	if [ -n "$BUFFER" ]; then
		zle accept-line
		return 0;
	fi

	echo
	ls_abbrev
	zle reset-prompt
	return 0
}

zle -N do_enter
bindkey '^m' do_enter

# show git-branch in rprompt

function rprompt-git-current-branch {
	local name st color

	if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi
        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=${fg[green]}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=${fg[yellow]}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=${fg_bold[red]}
        else
                color=${fg[red]}
        fi

        echo "%{$color%}$name%{$reset_color%}:"
}

case ${UID} in
0)
	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
	PROMPT="%B%{[36m%}[%n@%m]#%{[m%}%b "
	PROMPT2="%B%{[31m%}%_#%{[m%}%b "
	RPROMPT="%{[36m%}(`rprompt-git-current-branch`%{[36m%}%~%)%{[m%}"
	SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
	PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
	;;
*)
	PROMPT="%{[36m%}[%n@%m]%%%{[m%} "
	PROMPT2="%{[31m%}%_%%%{[m%} "
	RPROMPT='%{[36m%}(`rprompt-git-current-branch`%{[36m%}%~%)%{[m%}'
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
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

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

case "${OSTYPE}" in
freebsd*|darwin*)
	alias ls="ls -G -w"
	;;
linux*)
	alias ls="ls --color"
	;;
esac

alias a=alias
alias du="du -h"
alias df="df -h"
alias h="history"
alias j="jobs -l"
alias la="ls -aF"
alias lf="ls -F"
alias ll="ls -lF"
alias lla="ls -alF"
alias sc="screen -D -RR"
alias screen="screen -D -RR"
alias su="su -l"
alias va="vagrant"
alias where="command -v"

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

if [ "${PAGER}" != "less" ]; then
	alias less=$PAGER
fi

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

function ssh_screen()
{
	eval server=\${$#}
	/usr/bin/screen -t $server ssh "$@"
}

if [ "$TERM" = "screen" ]; then
	preexec() {
		# see [zsh-workers:13180]
		# http://www.zsh.org/mla/workers/2000/msg03993.html
		emulate -L zsh
		local -a cmd; cmd=(${(z)2})
		case $cmd[1] in
		fg)
			if (( $#cmd == 1 )); then
				cmd=(builtin jobs -l %+)
			else
				cmd=(builtin jobs -l $cmd[2])
			fi
			;;
		%*)
			cmd=(builtin jobs -l $cmd[1])
			;;
		cd)
			if (( $#cmd == 2)); then
				cmd[1]=$cmd[2]
			fi
			;;
		*)
			echo -n "k$cmd[1]:t\\"
			return
			;;
		esac
		local -A jt; jt=(${(kv)jobtexts})
		$cmd >>(read num rest
			cmd=(${(z)${(e):-\$jt$num}})
			echo -n "k$cmd[1]:t\\") 2>/dev/null
	}

	alias ssh=ssh_screen

	export LSCOLORS=ExFxCxdxBxegedabagacad
	export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
	zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'
fi

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
