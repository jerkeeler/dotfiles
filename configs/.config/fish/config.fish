# First thing first, look pretty
fish_config theme choose "Dracula Official"

# Set up common aliases
source ~/.config/fish/alias.fish

# Make sure homebrew in on the path baby
if test -e /opt/homebrew/bin/brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
end

# Init prompt and zoxide and other CLI utilities
starship init fish | source
zoxide init fish | source
direnv hook fish | source

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# Only need to source this cargo file if rust is installed manually and not through homebrew
# source "$HOME/.cargo/env.fish"
fish_add_path ~/go/bin

# Export and set important environment variables
# Using -gx instead of -Ux since universal vars persist and don't need to be set on every shell init
set -gx EDITOR "nvim"
set -gx LSCOLORS "gxfxbEaEBxxEhEhBaDaCaD"

# FZF configuration (using fd for better performance)
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'

# Set up private aliases and variables for specific machine
if test -e ~/.config/fish/private.fish
  source ~/.config/fish/private.fish
end
fish_add_path $HOME/.local/bin

# Note: broot launcher is configured separately via `broot --install`
# The br.fish function in functions/ handles shell integration

# Unlock keychain when connecting via SSH
#if test -n "$SSH_CONNECTION"
#  security unlock-keychain ~/Library/Keychains/login.keychain-db
#end
