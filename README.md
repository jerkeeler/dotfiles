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
4. Installing [oh-my-zsh](https://ohmyz.sh/#install)
5. Installing [tmux plugin manager](https://github.com/tmux-plugins/tpm)
6. Setting up configs with [GNU stow](https://www.gnu.org/software/stow/)
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
- Install [docker desktop](https://www.docker.com/products/docker-desktop/) if the homewbrew version doesn't work correctly
- Install [rust](https://www.rust-lang.org/tools/install)
  - `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

## Adding a new dotfiles

If you want to add a new config from somewhere, first create it in the `configs/` directory in this repo.
Think of the `configs/` directory as your home directory, so wherever the config actually lives in `~`
it should live in the same path under `configs/`. Once added run `stow configs/` to setup the symlink correctly.

## Device-specific config

Device specific .zshrc values should live in that devices `.zprofile`. For example if I have an `affirm-specific` alias, that would be stored in `.zprofile` on the Affirm device.
