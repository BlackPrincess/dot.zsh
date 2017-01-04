export BLOCKSIZE=K
export EDITOR=vi

# ------------------------------
# Ruby
# ------------------------------
eval "$(rbenv init - zsh)"

# ------------------------------
# Android
# ------------------------------
export ANDROID_HOME=/Applications/android-sdk-macosx
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/build-tools

# ------------------------------
# JVM SBT
# ------------------------------
export SBT_OPTS='-Xms2048M -Xmx2048M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxMetaspaceSize=4096M'
export JAVA_OPTS=$SBT_OPTS


# ------------------------------
# Haskell
# ------------------------------
export PATH=$PATH:$HOME/.cabal/bin

# ------------------------------
# Node.js
# ------------------------------
export PATH=$HOME/.nodebrew/current/bin:$PATH


# -----------------------------
# Elixir
# ------------------------------
export PATH="$HOME/.exenv/bin:$PATH"
eval "$(exenv init -)"


# -----------------------------
# Python
# ------------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# ------------------------------
# user custom commands
# ------------------------------
function sushi() {
	ruby -e 'C=`stty size`.scan(/\d+/)[1].to_i;S="\xf0\x9f\x8d\xa3";a={};puts "\033[2J";loop{a[rand(C)]=0;a.each{|x,o|;a[x]+=1;print "\033[#{o};#{x}H \033[#{a[x]};#{x}H#{S} \033[0;0H"};$stdout.flush;sleep 0.01}'
}
