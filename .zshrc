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
# Keybind configuration
# ------------------------------
. ${SCRIPT_DIR}/keybind.sh

# ------------------------------
# Command history configuration
# ------------------------------
. ${SCRIPT_DIR}/history.sh

# ------------------------------
# Completion configuration
# ------------------------------
. ${SCRIPT_DIR}/completion.sh

# ------------------------------
# Alias configuration
# ------------------------------
. $SCRIPT_DIR/alias.sh

# ------------------------------
# terminal configuration
# ------------------------------
. $SCRIPT_DIR/terminal.sh

# ------------------------------
# original settings
# ------------------------------
. ${SCRIPT_DIR}/extend.sh
