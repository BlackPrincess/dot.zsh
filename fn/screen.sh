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

  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'
fi