# First thing first, look pretty
fish_config theme choose "Dracula Official"

# Set up common aliases
source ~/.config/fish/alias.fish

# Make sure homebrew in on the path baby
eval "$(/usr/local/bin/brew shellenv)"
fish_add_path /opt/homebrew/bin/

# Init prompt and zoxide and another CLI utilities
starship init fish | source
zoxide init fish | source
fzf --fish | source

# Export and set important environment variables
set -Ux EDITOR "nvim"
set -Ux LSCOLORS "gxfxbEaEBxxEhEhBaDaCaD"
