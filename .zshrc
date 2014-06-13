# users generic .zshrc file for zsh(1)
SCRIPT_DIR="${HOME}/dot.zsh"

PROMPT=$'\U1F604 '
# ------------------------------
# Environment variable configuration
# ------------------------------
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit ; compinit
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
. $SCRIPT_DIR/extra/cd.sh
. $SCRIPT_DIR/extra/cd-git-root.sh
. $SCRIPT_DIR/extra/ls_abbrev.sh
. $SCRIPT_DIR/extra/ssh_screen.sh
. $SCRIPT_DIR/extra/rprompt_git_current_branch.sh
. $SCRIPT_DIR/extra/do_enter.sh
. $SCRIPT_DIR/extra/history-ranking.sh

# ------------------------------
# original settings
# ------------------------------
. ${SCRIPT_DIR}/extend.sh
