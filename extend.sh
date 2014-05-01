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
export SBT_OPTS='-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=1024M'

# ------------------------------
# Android
# ------------------------------
export ANDROID_HOME=/Applications/android-sdk-macosx
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/build-tools

# ------------------------------
# Haskell
# ------------------------------
export PATH=$PATH:$HOME/.cabal/bin

# ------------------------------
# user custom commands
# ------------------------------
. $SCRIPT_DIR/usercustom/extention-number.sh

function sushi() {
	ruby -e 'C=`stty size`.scan(/\d+/)[1].to_i;S="\xf0\x9f\x8d\xa3";a={};puts "\033[2J";loop{a[rand(C)]=0;a.each{|x,o|;a[x]+=1;print "\033[#{o};#{x}H \033[#{a[x]};#{x}H#{S} \033[0;0H"};$stdout.flush;sleep 0.01}'
}
