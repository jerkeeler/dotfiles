# Check if ~/.env exists. Use this file to set device-specific environment variables, such as AFFIRM to indicate work
# environment
# if [[ -f "$HOME/.env" ]]; then
#   # Export variables from ~/.env
#   export $(grep -v '^#' "$HOME/.env"| xargs)
# fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git asdf direnv)

source $ZSH/oh-my-zsh.sh

# MAKE SURE HOMEBREW IS SETUP AND ANY OTHER THINGS THAT MUST BE AT THE TOP
case "$(uname)" in
  Linux)
    # Linux
    ;;
  Darwin)
    # MacOS
    if ! command -v brew &> /dev/null; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    ;;
esac

# ===========================================================
# User configuration
# ===========================================================

# Manually set language environment, just in case
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


# Set up the pure prompt
case "$(uname)" in
  Linux)
    # Linux
    ;;
  Darwin)
    # MacOS
    fpath+=("$(brew --prefix)/share/zsh/site-functions")
    ;;
esac

autoload -U promptinit; promptinit

RED="#ff5c57"
GREEN="#5af78e"
YELLOW="#f3f99d"
BLUE="#57c7ff"
MAGENTA="#ff6ac1"
CYAN="#9aedfe"

zstyle :prompt:pure:execution_time color $YELLOW
zstyle :prompt:pure:path color $BLUE
zstyle :prompt:pure:prompt:error color $RED
zstyle :prompt:pure:pompt:success color $MAGENTA
PURE_PROMPT_SYMBOL="λ"
prompt pure

# Setup plugins and CLI utilities
case "$(uname)" in
  Linux)
    # Linux
    ;;
  Darwin)
    # MacOS
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ;;
esac
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git/*,**/*.pyc,node_modules/*,**/.mypy/*,.idea/*,**/.mypy_cache/*,**/.venv/*,**/*.egg-info/*}"'
source $HOME/.config/broot/launcher/bash/br
eval "$(zoxide init zsh)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
case "$(uname)" in
  Linux)
    # Linux
    ;;
  Darwin)
    # MacOS
    alias bup="brew update && brew upgrade"
    alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
    alias ledger="cd ~/Documents/Personal\ Important/personal_ledger/"
    alias dev="cd ~/Developer"
    ;;
esac

alias cl="clear"
alias v="nvim"
alias projects="cd ~/projects"
alias aom="cd ~/projects/aomstats"
alias glog="git log --oneline --graph"
