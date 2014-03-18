# users generic .zshrc file for zsh(1)
SCRIPT_DIR="${HOME}/.zsh"

# ------------------------------
# Environment variable configuration
# ------------------------------
. ${SCRIPT_DIR}/environment.sh

# ------------------------------
# Default shell configuration
# ------------------------------
. ${SCRIPT_DIR}/default.sh

# ------------------------------
# Load configuration
# ------------------------------
. $SCRIPT_DIR/conf.d/terminal-color.sh
. $SCRIPT_DIR/conf.d/history.sh
. $SCRIPT_DIR/conf.d/alias.sh
. $SCRIPT_DIR/conf.d/pager.sh
. $SCRIPT_DIR/conf.d/keybind.sh
. $SCRIPT_DIR/conf.d/screen.sh

# ------------------------------
# Load Command
# ------------------------------
# find $SCRIPT_DIR/extend-commands -name "*.sh" -exec . {} \;
. $SCRIPT_DIR/extend-commands/cd.sh
. $SCRIPT_DIR/extend-commands/git-svn-clone.sh
. $SCRIPT_DIR/extend-commands/git-reset-clean.sh
. $SCRIPT_DIR/extend-commands/ls_abbrev.sh
. $SCRIPT_DIR/extend-commands/ssh_screen.sh
. $SCRIPT_DIR/extend-commands/rprompt_git_current_branch.sh
. $SCRIPT_DIR/extend-commands/do_enter.sh

# ------------------------------
# original settings
# ------------------------------
. ${SCRIPT_DIR}/extend.sh
