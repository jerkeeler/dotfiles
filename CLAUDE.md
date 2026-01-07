# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository using GNU Stow for symlink management. The `configs/` directory mirrors `$HOME` structure.

## Common Commands

- `./setup.sh` - Full installation (Command Line Tools, Homebrew, Brewfile, tmux TPM, stow)
- `./update.sh` - Pull latest, re-link configs, update Brewfile packages
- `stow configs/` - Re-link dotfiles after edits
- `brew bundle install` - Install/update Homebrew dependencies
- `strfile extra_fortunes` - Recompile fortune database after editing

## Structure

- `configs/` - GNU Stow packages mirroring `$HOME` (e.g., `configs/.config/nvim/` → `~/.config/nvim/`)
- `Brewfile` - Homebrew dependencies
- `extra_fortunes` / `extra_fortunes.dat` - Custom fortune entries

## Key Conventions

- When searching, include dotfiles under `configs/` (notably `configs/.config/`); include hidden files but ignore `.git/`
- Store new dotfiles under `configs/` using the same path they occupy in `$HOME`
- Bash scripts use `#!/usr/bin/env bash` with linear steps
- Device-specific config goes in `.zprofile` on that device, not in this repo
- Automated commit messages must be thorough and descriptive
