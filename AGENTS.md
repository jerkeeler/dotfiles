# Repository Guidelines

This repository contains personal dotfiles managed with GNU Stow for macOS. It includes configurations for Neovim, Fish shell, tmux, Ghostty terminal, OpenCode, and various CLI tools.

## Project Structure & Module Organization

- **Root files** - Setup and maintenance: `Brewfile`, `setup.sh`, `update.sh`, `README.md`
- **configs/** - GNU Stow packages; paths mirror `$HOME` (e.g., `configs/.config/nvim/init.lua` → `~/.config/nvim/init.lua`)
- **Neovim structure**:
  - `configs/.config/nvim/init.lua` - Entry point, loads config modules
  - `configs/.config/nvim/lua/config/` - Core configuration (sets, remaps, lazy plugin manager)
  - `configs/.config/nvim/lua/plugins/` - Plugin configurations (one file per plugin)
  - `configs/.config/nvim/ftplugin/` - Filetype-specific settings
- **Fish shell structure**:
  - `configs/.config/fish/config.fish` - Main Fish configuration
  - `configs/.config/fish/alias.fish` - Shell aliases and abbreviations
  - `configs/.config/fish/functions/` - Custom Fish functions
- **Fortune database** - `extra_fortunes` (source) and `extra_fortunes.dat` (compiled)

**Important**: When searching or exploring, include dotfiles under `configs/` (notably `configs/.config/`); include hidden files but ignore `.git/`.

## Build, Test, and Development Commands

### Setup and Installation
```bash
./setup.sh              # Full setup: installs Xcode CLI tools, Homebrew, packages, TPM, runs stow
./update.sh             # Update: git pull, re-stow configs, update Homebrew packages
brew bundle install     # Install/update Homebrew dependencies from Brewfile
```

### Configuration Management
```bash
stow configs/           # Create/update symlinks from configs/ to $HOME
stow -D configs/        # Remove symlinks (useful before deleting config files)
stow -R configs/        # Restow (remove then recreate symlinks)
```

### Component-Specific Commands
```bash
# Fortune database
strfile extra_fortunes  # Recompile fortune database after editing extra_fortunes

# Neovim plugins
nvim                    # Launch Neovim, Lazy.nvim auto-installs plugins on first run
:Lazy sync              # Update all plugins (inside Neovim)
:Lazy clean             # Remove unused plugins

# Tmux
<C-space> I             # Install TPM plugins (inside tmux, prefix + Shift-I)
<C-space> r             # Reload tmux config
```

### Testing and Validation
- **No automated tests defined**
- Validate Stow changes: Run `stow configs/` and verify symlinks with `ls -la ~/.config/`
- After Brewfile edits: Run `brew bundle install` to confirm dependencies install cleanly
- For fortune updates: Run `strfile extra_fortunes` and verify `extra_fortunes.dat` changes

## Code Style & Naming Conventions

### General Principles
- Follow existing patterns in the codebase strictly
- Keep configurations simple and well-commented
- Use descriptive variable and function names
- Comment only non-obvious logic, not self-explanatory code

### Bash Scripts
- **Shebang**: Always use `#!/usr/bin/env bash`
- **Style**: Linear execution flow, avoid complex control structures
- **Comments**: Explain why, not what; include source URLs for adapted code
- **Error handling**: Use `|| { }` pattern for error conditions
- **Example pattern**:
  ```bash
  #!/usr/bin/env bash
  
  # Check if tool exists before running
  command -v tool >/dev/null || {
    echo "Error: tool not found"
    exit 1
  }
  ```

### Lua (Neovim Configuration)
- **Plugin files**: Return a table with plugin spec (lazy.nvim format)
- **Indentation**: 2 spaces (use tabs=false, expandtab=true, shiftwidth=2)
- **Quotes**: Use double quotes for strings
- **Functions**: Define local functions at module scope, use descriptive names
- **Keymaps**: Use `vim.keymap.set()` with `{ silent = true }` option
- **Comments**: Use `--` for single line, section headers with dashed lines
- **Example plugin structure**:
  ```lua
  return {
    "author/plugin-name",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local plugin = require("plugin-name")
      
      plugin.setup({
        option = value,
      })
      
      -- Keymaps
      vim.keymap.set("n", "<leader>x", "<cmd>Command<cr>", { silent = true })
    end,
  }
  ```

### Fish Shell
- **Functions**: One file per function in `functions/` directory
- **Aliases**: Use `alias` for simple substitutions, `abbr` for git commands
- **Indentation**: 2 spaces
- **Conditionals**: Use `if test` syntax, not `if [ ]`
- **Variables**: Use `set -gx` for global exports, `set -Ux` for universal variables
- **Example function**:
  ```fish
  function my_function
    # Brief description of what function does
    if test -e /path/to/thing
      do_something
    else
      do_something_else
    end
  end
  ```

### JSON Configuration Files
- **Indentation**: 2 spaces
- **Schema**: Include `$schema` reference when available
- **Formatting**: Run through prettier or maintain consistent style

### File Naming
- **Lua**: lowercase with hyphens (e.g., `vim-tmux-navigator.lua`, `fzf-lua.lua`)
- **Fish**: lowercase with underscores (e.g., `fish_greeting.fish`, `gco_remote.fish`)
- **Bash**: lowercase with underscores or hyphens (e.g., `setup.sh`, `update.sh`)

## Configuration-Specific Guidelines

### OpenCode Configuration
- Location: `configs/.config/opencode/opencode.json`
- Vim-like keybindings configured: `Ctrl+U` (scroll up), `Ctrl+D` (scroll down)
- Leader key: `Ctrl+X` (default)
- Theme: `one-dark`
- After editing: Run `stow configs/` to apply changes

### Neovim Leader Keys
- `<leader>` = `Space`
- `<localleader>` = `\`
- Prefix key patterns:
  - `<leader>f*` - FzfLua/file operations
  - `<leader>n*` - NvimTree operations
  - `<leader>t*` - Tab/time operations
  - `<leader>g*` - Git operations

### Tmux Prefix
- Prefix: `Ctrl+Space` (not default `Ctrl+B`)
- Vi mode enabled in copy mode
- Custom split bindings: `|` (vertical), `-` (horizontal)

## Device-Specific Configuration

**Never commit device-specific values to this repository.** Use local configuration files:

- **Fish**: `~/.config/fish/conf.d/local.fish` (not tracked)
- **Zsh**: `~/.zprofile` (not tracked)
- **Example**: Enabling Windsurf AI on a specific machine:
  ```fish
  # In ~/.config/fish/conf.d/local.fish
  set -gx ENABLE_WINDSURF 1
  ```

## Commit & Pull Request Guidelines

### Commit Messages
- **Format**: Descriptive summary line, followed by detailed bullet points
- **Style**: Use imperative mood ("Add feature" not "Added feature")
- **Content**: Explain what changed and why, include relevant context
- **Example**:
  ```
  Add OpenCode configuration with vim-like keybindings
  
  - Add opencode.json config with one-dark theme and vim-style scrolling
  - Configure Ctrl+U/Ctrl+D for half-page scrolling (vim-style navigation)
  - Add opencode to Brewfile for dependency tracking
  - Document OpenCode configuration in AGENTS.md
  ```

### Pull Requests
- Include brief summary of changes
- Document any manual setup steps required
- Note macOS-specific assumptions or requirements
- Test with `./update.sh` to ensure stow operations work correctly

## Security & Best Practices

### Secrets Management
- **Never commit**: API keys, tokens, passwords, machine-specific secrets
- **Use device-specific configs**: Store sensitive values in `.zprofile` or `local.fish`
- **Git safety**: Files like `.env`, `credentials.json` should never be committed

### Dependency Management
- **Brewfile**: Document all Homebrew dependencies in `Brewfile`
- **Avoid ad-hoc installs**: Add to `Brewfile` rather than manual notes
- **Version pinning**: Generally use latest stable versions unless specific version required

### Path Conventions
- **Absolute paths**: Use `$HOME` or `~` for user-relative paths in configs
- **Stow compatibility**: Ensure config paths match their target locations in `$HOME`
- **Symlink awareness**: Remember that configs/ files are symlinked, not copied

## Common Patterns and Anti-Patterns

### ✅ DO
- Use `vim.keymap.set()` in Neovim (modern API)
- Keep plugin configs in separate files under `lua/plugins/`
- Add comments explaining complex logic or borrowed code
- Test stow operations after adding new configs
- Use project-local `.nvim.lua` for monorepo whitelist filtering

### ❌ DON'T
- Don't use deprecated APIs (e.g., `vim.api.nvim_set_keymap` vs `vim.keymap.set`)
- Don't commit untested Brewfile changes
- Don't hardcode machine-specific paths or values
- Don't create deeply nested directory structures unnecessarily
- Don't mix tabs and spaces in same file type

## Special Features

### Monorepo Whitelist Filtering
Create `.nvim.lua` in project root to limit searches to specific folders:
```lua
vim.g.project_whitelist = { "services/api", "packages/frontend" }
vim.g.project_root = vim.fn.getcwd()
```
- Whitelist-aware: `<leader>ff`, `<leader>fg`, `<leader>fw`, `<leader>n`
- Bypass whitelist: `<leader>fF`, `<leader>fG`, `<leader>fW`, `<leader>N`

### Custom Tmux + Neovim Navigation
- Seamless navigation between tmux panes and Neovim splits
- Keybindings: `Ctrl+h/j/k/l` for left/down/up/right
- Implementation: `configs/.config/nvim/lua/plugins/vim-tmux-navigator.lua`
- Uses async jobstart to avoid blocking

## Useful Resources

- GNU Stow manual: https://www.gnu.org/software/stow/manual/stow.html
- Lazy.nvim plugin spec: https://lazy.folke.io/spec
- Fish shell documentation: https://fishshell.com/docs/current/
- Tmux configuration: https://github.com/tmux/tmux/wiki
