export BLOCKSIZE=K
export EDITOR=vi

# ------------------------------
# Ruby
# ------------------------------
if [[ -s /usr/local/bin/rbenv ]] ; then
  # rbenv
  eval "$(rbenv init - zsh)"
elif [[ -s $HOME/.rvm/scripts/rvm ]] ; then
  # rvm
  source $HOME/.rvm/scripts/rvm
fi

# ------------------------------
# JVM SBT
# ------------------------------
export SBT_OPTS='-Xms256m -Xmx512m -Xss1M -XX:MaxPermSize=1024m'


# ------------------------------
# Android
# ------------------------------
export ANDROID_HOME=/Applications/android-sdk-macosx
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/build-tools