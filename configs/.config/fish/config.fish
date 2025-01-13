# First thing first, look pretty
fish_config theme choose "Dracula Official"

# Set up common aliases
source ~/.config/fish/alias.fish
# Set up private aliases and variables for specific machine
if test -e ~/.config/fish/private.fish
  source ~/.config/fish/private.fish
end

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
source "$(brew --prefix asdf)"/libexec/asdf.fish
# Only need to source this cargo file if rust is installed manually and not through homebrew
# source "$HOME/.cargo/env.fish"
fish_add_path ~/go/bin

# Export and set important environment variables
set -Ux EDITOR "nvim"
set -Ux LSCOLORS "gxfxbEaEBxxEhEhBaDaCaD"
