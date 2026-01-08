# Jeremy's dotfiles

My dotfiles, using stow to create symlinks. This only works for MacOS as that's what I use. My dotfiles, my way...
Although it'd be nice if this also worked on linux.

## Installation

### Part 1

Theoretically... all you have to do is run `setup.sh`

```bash
./setup.sh
```

What setup.sh is doing in the background:

1. Installing command line tools
2. Installing [homebrew](https://brew.sh)
3. Running `brew bundle install` to install everything in `Brewfile`
4. Installing [tmux plugin manager](https://github.com/tmux-plugins/tpm)
5. Setting up configs with [GNU stow](https://www.gnu.org/software/stow/)
   - Which is just running the `stow configs/` command

### Part 2

Follow ups to get everything to work:

- Set your default shell to fiiiiiiiish
  ```
  chsh -s /opt/homebrew/bin/fish
  ```
- Start tmux, then install all plugins with `<prefix> + I` or `<C-space + I>` if `<C-space>` is the prefix (which it is)
- Start nvim and everything should install, once finished, quit and restart
- Install nodejs 22+ for neovim LSP plugins to work
  - Can be installed using [asdf](https://asdf-vm.com) which is installed via homebrew
  - `asdf plugin-add nodejs && asdf install nodejs 22.12.0 && asdf global nodejs 22.12.0`
- [Setup a new ssh key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), attach it to GitHub and any machines you need to ssh into
- Install [docker desktop](https://www.docker.com/products/docker-desktop/) if the homebrew version doesn't work correctly
- Install [rust](https://www.rust-lang.org/tools/install)
  - `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

## Key Features

### Seamless Tmux + Neovim Navigation

Navigate between tmux panes and Neovim splits using a single set of keybindings with a custom async implementation that eliminates lag.

**Keybindings:**

- `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` - Navigate left/down/up/right

When you're at the edge of a Neovim window, the navigation automatically transitions to tmux panes. The implementation uses asynchronous tmux commands to avoid blocking the editor.

**Configuration:**

- `configs/.config/nvim/lua/plugins/vim-tmux-navigator.lua` - Custom Lua implementation
- Works seamlessly without any additional setup after installation

### Monorepo Folder Filtering

For large monorepo projects, you can configure Neovim to only show and search specific folders, dramatically improving performance and focus.

**Setup:**
Create a `.nvim.lua` file in your project root:

```lua
vim.g.project_whitelist = { "services/api", "packages/frontend", "libs/common" }
vim.g.project_root = vim.fn.getcwd()
```

**Whitelist-aware keybindings:**

- `<leader>ff` - Search files (respects whitelist)
- `<leader>fg` - Live grep (respects whitelist)
- `<leader>fw` - Grep word under cursor (respects whitelist)
- `<leader>n` - Toggle nvim-tree (with whitelist filter)

**Bypass whitelist with uppercase variants:**

- `<leader>fF` - Search all files
- `<leader>fG` - Live grep all files
- `<leader>fW` - Grep word in all files
- `<leader>N` - Toggle nvim-tree without filter

**Features:**

- Top-level files are always visible (only folders are filtered)
- Integrates with both fzf-lua and nvim-tree
- Neovim will prompt before executing `.nvim.lua` files for security

**Configuration:**

- `configs/.config/nvim/lua/config/whitelist.lua` - Core filtering module
- `configs/.config/nvim/lua/plugins/fzf-lua.lua` - FzfLua integration
- `configs/.config/nvim/lua/plugins/nvim-tree.lua` - File tree integration

### AI-Powered Code Completion

Windsurf (formerly Codeium) provides AI autocomplete in Neovim with virtual text suggestions.

**Enable on a specific device** (device-local config only):

**Fish** (`~/.config/fish/conf.d/local.fish`):

```fish
set -gx ENABLE_WINDSURF 1
```

**Zsh** (`~/.zprofile`):

```bash
export ENABLE_WINDSURF=1
```

**Keybindings:**

- `Tab` - Accept full suggestion
- `Ctrl-Right` - Accept next word
- `Ctrl-Down` - Accept next line
- `Meta-]` / `Meta-[` - Cycle through suggestions
- `Ctrl-]` - Clear suggestion

**First-time setup:**

1. Set the environment variable in your device-local config
2. Restart Neovim
3. Run `:Codeium Auth` to authenticate

**Configuration:**

- `configs/.config/nvim/lua/plugins/windsurf.lua` - Plugin configuration
- Only loads when `ENABLE_WINDSURF` environment variable is set

### Claude Code Integration

This repository includes `CLAUDE.md` with guidance for Claude Code (claude.ai/code) when working with these dotfiles.

**Key conventions documented:**

- Repository structure and common commands
- Searching patterns (include dotfiles, ignore `.git/`)
- Device-specific vs repository configuration
- Commit message standards

This ensures AI assistants understand the repository's organization and conventions automatically.

## Adding a new dotfiles

If you want to add a new config from somewhere, first create it in the `configs/` directory in this repo.
Think of the `configs/` directory as your home directory, so wherever the config actually lives in `~`
it should live in the same path under `configs/`. Once added run `stow configs/` to setup the symlink correctly.

## Device-specific config

Device specific values should live outside of this repo. For zsh, use `.zprofile`. For fish, use `~/.config/fish/conf.d/local.fish`. For example if I have an `affirm-specific` alias, that would be stored in one of these files on the Affirm device.

See the [AI-Powered Code Completion](#ai-powered-code-completion) section for enabling Windsurf autocomplete on specific devices.

## Adding more fortunes

The message of the day prompt generates a random fortune using the `fortune` utility. It also adds extra fortunes found in the `extra_fortunes` file. To get these files
to work correctly you must compile it into a `.dat` file. Use the following command to do so:

```bash
strfile extra_fortunes
```

`extra_fortunes` must have a new fortune on each line and each line must be separated by a %.
