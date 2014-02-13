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