function git-reset-clean() {
  git reset --hard HEAD && git clean -f -d
}