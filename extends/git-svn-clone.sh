function git-svn-clone() {
  git svn clone $@ -T trunk -b branches -t tags
}
