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
**Bypass whitelist with uppercase variants:**

- `<leader>fF` - Search all files
- `<leader>fG` - Live grep all files
- `<leader>fW` - Grep word in all files

**Features:**

- Top-level files are always visible (only folders are filtered)
- Integrates with fzf-lua for searching
- Neovim will prompt before executing `.nvim.lua` files for security

**Configuration:**

- `configs/.config/nvim/lua/config/whitelist.lua` - Core filtering module
- `configs/.config/nvim/lua/plugins/fzf-lua.lua` - FzfLua integration

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
- `Meta-f` - Accept next word
- `Meta-e` - Accept next line
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

## Keybindings Reference

A comprehensive guide to all custom keybindings across Neovim, tmux, and Fish shell.

### Neovim Keybindings

**Leader Key:** `Space`
**Local Leader:** `\`

#### Navigation

| Keybind        | Action                             | Source             |
| -------------- | ---------------------------------- | ------------------ |
| `Ctrl+h/j/k/l` | Navigate between splits/tmux panes | vim-tmux-navigator |
| `Ctrl+u`       | Half-page up (centered)            | remap.lua          |
| `Ctrl+d`       | Half-page down (centered)          | remap.lua          |
| `n`            | Next search result (centered)      | remap.lua          |
| `N`            | Previous search result (centered)  | remap.lua          |
| `[d`           | Previous diagnostic                | remap.lua          |
| `]d`           | Next diagnostic                    | remap.lua          |
| `[c`           | Previous git hunk                  | gitsigns           |
| `]c`           | Next git hunk                      | gitsigns           |

#### File Search (FzfLua)

| Keybind      | Action                 | Notes              |
| ------------ | ---------------------- | ------------------ |
| `<leader>ff` | Find files             | Respects whitelist |
| `<leader>fg` | Live grep              | Respects whitelist |
| `<leader>fw` | Grep word under cursor | Respects whitelist |
| `<leader>fb` | Search buffers         |                    |
| `<leader>fd` | LSP document symbols   |                    |
| `<leader>fF` | Find all files         | Bypasses whitelist |
| `<leader>fG` | Live grep all          | Bypasses whitelist |
| `<leader>fW` | Grep word in all files | Bypasses whitelist |

#### Harpoon (Quick File Access)

| Keybind        | Action                   |
| -------------- | ------------------------ |
| `<leader>a`    | Add file to harpoon      |
| `<leader>d`    | Remove file from harpoon |
| `Ctrl+e`       | Toggle harpoon menu      |
| `<leader>1`    | Jump to harpoon slot 1   |
| `<leader>2`    | Jump to harpoon slot 2   |
| `<leader>3`    | Jump to harpoon slot 3   |
| `<leader>4`    | Jump to harpoon slot 4   |
| `Ctrl+Shift+P` | Previous harpoon item    |
| `Ctrl+Shift+N` | Next harpoon item        |

#### File Explorer (yazi)

| Keybind      | Action                            |
| ------------ | --------------------------------- |
| `<leader>-`  | Open yazi at current file         |
| `<leader>cw` | Open yazi at working directory    |
| `<C-up>`     | Resume last yazi session          |

#### LSP

| Keybind      | Action                            |
| ------------ | --------------------------------- |
| `gd`         | Go to definition                  |
| `gr`         | Go to references                  |
| `gi`         | Go to implementation              |
| `gt`         | Go to type definition             |
| `se`         | Show diagnostic float             |
| `<leader>e`  | Show diagnostic float (alternate) |
| `<leader>rn` | Rename symbol                     |
| `<leader>cf` | Format file/selection             |

#### Git (gitsigns + fugitive)

| Keybind      | Action              |
| ------------ | ------------------- |
| `[c`         | Previous git hunk   |
| `]c`         | Next git hunk       |
| `<leader>gp` | Preview git hunk    |
| `<leader>gb` | Git blame line      |
| `<leader>gr` | Reset git hunk      |
| `<leader>gR` | Reset git buffer    |
| `<leader>gs` | Stage git hunk      |
| `<leader>gu` | Undo stage git hunk |

#### Git Workflow with Fugitive

Fugitive provides a powerful git interface inside Neovim. Here's how to review and manage uncommitted changes:

**Opening the Git Status Screen:**

```
:Git
```

This opens a split showing the current git status with staged/unstaged files.

**Navigating the Status Screen:**

| Keybind | Action                                         |
| ------- | ---------------------------------------------- |
| `j/k`   | Move down/up through files                     |
| `=`     | Toggle inline diff for file under cursor       |
| `Enter` | Open file in a new split                       |
| `o`     | Open file in a horizontal split                |
| `gO`    | Open file in a vertical split                  |
| `O`     | Open file in a new tab                         |
| `p`     | Open file in preview window                    |
| `~`     | Open file's parent tree object                 |
| `)`/`(` | Jump to next/previous file                     |
| `]c`    | Jump to next hunk in diff                      |
| `[c`    | Jump to previous hunk in diff                  |
| `i`     | Jump to next file/hunk, expanding inline diffs |
| `dv`    | Open vertical diff split (`:Gvdiffsplit`)      |
| `dd`    | Open horizontal diff split (`:Gdiffsplit`)     |
| `g?`    | Show help with all available mappings          |

**Staging and Unstaging:**

| Keybind | Action                                                |
| ------- | ----------------------------------------------------- |
| `s`     | Stage file or hunk under cursor                       |
| `u`     | Unstage file or hunk under cursor                     |
| `-`     | Toggle staging (stage if unstaged, unstage if staged) |
| `X`     | Discard changes to file under cursor (careful!)       |
| `I`     | Add file to `.gitignore`                              |

**Committing:**

| Keybind | Action                                        |
| ------- | --------------------------------------------- |
| `cc`    | Create a commit (opens commit message editor) |
| `ca`    | Amend the last commit                         |
| `ce`    | Amend without editing message                 |
| `cw`    | Reword the last commit message                |
| `cvc`   | Create commit with verbose diff shown         |

**Other Useful Commands:**

| Command         | Action                                     |
| --------------- | ------------------------------------------ |
| `:Git blame`    | Show git blame in a vertical split         |
| `:Git log`      | Show git log                               |
| `:Git log %`    | Show git log for current file              |
| `:Gvdiffsplit`  | Vertical diff of current file vs index     |
| `:Gvdiffsplit!` | 3-way merge diff (for conflict resolution) |
| `:GBrowse`      | Open current file on GitHub (vim-rhubarb)  |

**Typical Workflow:**

1. Run `:Git` to open status screen
2. Navigate with `j/k` to a changed file
3. Press `=` to expand inline diff and review changes
4. Press `]c`/`[c` to jump between hunks within the diff
5. Press `s` to stage the file (or specific hunks if in diff view)
6. Press `-` to toggle staging if you change your mind
7. Repeat for other files
8. Press `cc` to commit when ready
9. Write commit message, save and close (`:wq`)
10. Press `q` to close the fugitive status window

#### GitHub Integration (vim-rhubarb)

vim-rhubarb extends fugitive with GitHub support. Useful for quickly jumping to GitHub from Neovim.

| Command              | Action                                      |
| -------------------- | ------------------------------------------- |
| `:GBrowse`           | Open current file on GitHub in browser      |
| `:GBrowse!`          | Copy GitHub URL to clipboard (don't open)   |
| `:'<,'>GBrowse`      | Open selected lines on GitHub (visual mode) |
| `:GBrowse @upstream` | Open file on upstream remote                |
| `:GBrowse HEAD~3:%`  | Open file 3 commits ago                     |

In fugitive's `:Git` status screen, you can also press `Enter` on a commit to view it, then use `:GBrowse` to open that commit on GitHub.

#### GitHub PR Reviews (octo.nvim)

octo.nvim provides a full GitHub PR and Issue management interface inside Neovim.

**Prerequisites:**

- GitHub CLI (`gh`) must be installed and authenticated (`gh auth login`)

**Opening PRs and Issues:**

| Command                      | Action                              |
| ---------------------------- | ----------------------------------- |
| `:Octo pr list`              | List PRs for current repo           |
| `:Octo pr search`            | Search PRs with query               |
| `:Octo pr edit <number>`     | Open PR by number                   |
| `:Octo pr create`            | Create a new PR from current branch |
| `:Octo pr checkout <number>` | Checkout PR branch locally          |
| `:Octo issue list`           | List issues for current repo        |
| `:Octo issue create`         | Create a new issue                  |
| `:Octo issue edit <number>`  | Open issue by number                |

**Navigating a PR (in PR buffer):**

| Keybind | Action                    |
| ------- | ------------------------- |
| `]c`    | Next comment              |
| `[c`    | Previous comment          |
| `]f`    | Next changed file         |
| `[f`    | Previous changed file     |
| `<CR>`  | Open file / expand thread |
| `<C-o>` | Go back                   |

**PR Actions:**

| Keybind      | Action                             |
| ------------ | ---------------------------------- |
| `<leader>ca` | Add comment                        |
| `<leader>cd` | Delete comment                     |
| `<leader>sa` | Add suggestion (in diff view)      |
| `<leader>ic` | Add inline comment on current line |
| `<leader>la` | Add label                          |
| `<leader>ld` | Remove label                       |
| `<leader>ra` | Add reviewer                       |
| `<leader>rd` | Remove reviewer                    |
| `<leader>aa` | Add assignee                       |
| `<leader>ad` | Remove assignee                    |

**Review Actions:**

| Keybind      | Action                        |
| ------------ | ----------------------------- |
| `<leader>va` | Start review                  |
| `<leader>vs` | Submit review                 |
| `<leader>vd` | Discard/delete pending review |
| `<leader>vr` | Resume pending review         |

**PR Management:**

| Keybind      | Action                |
| ------------ | --------------------- |
| `<leader>pm` | Merge PR              |
| `<leader>pc` | Close PR              |
| `<leader>pn` | Checkout PR           |
| `<leader>po` | Open PR in browser    |
| `<leader>pr` | Reopen PR             |
| `<leader>pp` | List PR commits       |
| `<leader>pf` | List PR changed files |

**Viewing PR Diffs:**

| Command            | Action             |
| ------------------ | ------------------ |
| `:Octo pr diff`    | Show PR diff       |
| `:Octo pr changes` | List changed files |
| `:Octo pr commits` | List commits in PR |

**Typical PR Review Workflow:**

1. Run `:Octo pr list` to see open PRs (uses fzf-lua picker)
2. Select a PR to open it in a buffer
3. Press `<leader>pf` to list changed files, select one to view diff
4. Navigate hunks with `]c`/`[c`
5. Press `<leader>ic` to add inline comment on a specific line
6. Press `<leader>va` to start your review
7. Continue reviewing files and adding comments
8. Press `<leader>vs` to submit review (approve/request changes/comment)
9. Press `<leader>pm` to merge if approved

**Tip:** Run `:Octo actions` to see all available actions in current context, or press `g?` for help.

#### Comments (Comment.nvim)

| Keybind       | Action                                     |
| ------------- | ------------------------------------------ |
| `gcc`         | Toggle line comment                        |
| `gbc`         | Toggle block comment                       |
| `gc{motion}`  | Comment with motion (e.g., `gcip`, `gc5j`) |
| `gc` (visual) | Comment selection                          |
| `gb` (visual) | Block comment selection                    |
| `gco`         | Add comment below                          |
| `gcO`         | Add comment above                          |
| `gcA`         | Add comment at end of line                 |

#### Windows & Buffers

| Keybind      | Action           |
| ------------ | ---------------- |
| `<leader>so` | Vertical split   |
| `<leader>sp` | Horizontal split |
| `<leader>l`  | Next buffer      |
| `<leader>h`  | Previous buffer  |
| `<leader>bd` | Delete buffer    |
| `<leader>tn` | Next tab         |
| `<leader>tp` | Previous tab     |
| `Ctrl+Arrow` | Resize window    |
| `<leader>x`  | Close window     |

#### Editing & Misc

| Keybind              | Action                             |
| -------------------- | ---------------------------------- |
| `<leader>w`          | Fast save                          |
| `<leader>p` (visual) | Paste without overwriting register |
| `<leader>pp`         | Toggle paste mode                  |
| `<leader>ss`         | Toggle spell check                 |
| `<leader><CR>`       | Clear search highlight             |
| `<leader>q`          | Open scratch buffer (`~/buffer`)   |
| `<leader>ut`         | Toggle undotree                    |

#### Obsidian

| Keybind      | Action                     |
| ------------ | -------------------------- |
| `<leader>nn` | Create new Obsidian note   |
| `<leader>tt` | Insert formatted date link |

### tmux Keybindings

**Prefix Key:** `Ctrl+Space`

#### Navigation

| Keybind        | Action                                          |
| -------------- | ----------------------------------------------- |
| `Ctrl+h/j/k/l` | Navigate between panes (integrates with Neovim) |

#### Pane Management

| Keybind            | Action                              |
| ------------------ | ----------------------------------- |
| `<prefix> \|`      | Split vertically                    |
| `<prefix> -`       | Split horizontally                  |
| `<prefix> h/j/k/l` | Resize pane (repeatable)            |
| `<prefix> m`       | Toggle pane zoom (maximize/restore) |

#### Window Management

| Keybind          | Action            |
| ---------------- | ----------------- |
| `<prefix> Left`  | Move window left  |
| `<prefix> Right` | Move window right |

#### Copy Mode (vi-style)

| Keybind           | Action                         |
| ----------------- | ------------------------------ |
| `<prefix> [`      | Enter copy mode                |
| `v`               | Begin selection (in copy mode) |
| `y`               | Copy selection (in copy mode)  |
| `PageUp/PageDown` | Scroll half-page               |
| `P`               | Paste buffer                   |

#### Misc

| Keybind      | Action              |
| ------------ | ------------------- |
| `<prefix> r` | Reload tmux config  |
| `<prefix> I` | Install TPM plugins |

### Fish Shell

#### Aliases

| Alias    | Command                     |
| -------- | --------------------------- |
| `v`      | `nvim`                      |
| `vim`    | `nvim`                      |
| `l`      | `ls -lah`                   |
| `cl`     | `clear`                     |
| `reload` | Reload fish shell           |
| `..`     | `cd ..`                     |
| `...`    | `cd ../..`                  |
| `....`   | `cd ../../..`               |
| `prev`   | `cd -` (previous directory) |
| `ta`     | `tmux attach`               |
| `dev`    | `cd ~/Developer`            |
| `obs`    | Open Obsidian vault in nvim |
| `glog`   | `git log --oneline --graph` |

#### Git Abbreviations

| Abbr            | Expansion                             |
| --------------- | ------------------------------------- |
| `gs`            | `git status -sb`                      |
| `ga`            | `git add`                             |
| `gc`            | `git commit -am "` (cursor in quotes) |
| `gcm`           | `git commit -m`                       |
| `gco`           | `git checkout`                        |
| `gp`            | `git push`                            |
| `gpl`           | `git pull`                            |
| `gd`            | `git diff`                            |
| `update_master` | `git fetch origin master:master`      |
| `update_main`   | `git fetch origin main:main`          |

#### Custom Functions

| Function              | Description                     |
| --------------------- | ------------------------------- |
| `mkcd <dir>`          | Create directory and cd into it |
| `bup`                 | Update and upgrade Homebrew     |
| `pull`                | Git fetch with prune + pull     |
| `gco_remote <branch>` | Checkout remote branch safely   |
| `br`                  | Broot file manager integration  |
| `unlock`              | Unlock macOS keychain           |

### Ghostty Terminal

| Keybind             | Action                  |
| ------------------- | ----------------------- |
| `Cmd+Shift+`` `     | Toggle quick terminal   |
| `Cmd+Shift+H/J/K/L` | Navigate between splits |
