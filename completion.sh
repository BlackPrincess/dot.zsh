# ------------------------------
# Completion configuration
# ------------------------------
autoload -U compinit
compinit

# default pager
if [ -x "`which lv`" ]; then
  export PAGER=lv
elif [ -x "`which jless`" ]; then
  export PAGER=jless
elif [ -x "`which less`" ]; then
  export PAGER=less
  export LESS='-R'
  export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
else
  export PAGER=more
fi