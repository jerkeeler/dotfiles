# Repository Guidelines

## Project Structure & Module Organization

- Root files cover setup and maintenance: `Brewfile`, `setup.sh`, `update.sh`, and `README.md`.
- `configs/` holds GNU Stow packages; paths should mirror `$HOME` (example: `configs/.config/nvim/init.lua`).
- `extra_fortunes` contains custom fortune entries and `extra_fortunes.dat` is the compiled database.

## Build, Test, and Development Commands

- `./setup.sh` installs macOS Command Line Tools, Homebrew, Brewfile packages, tmux TPM, and runs `stow configs/`.
- `./update.sh` pulls latest changes, re-runs `stow configs/`, and refreshes Brewfile packages.
- `brew bundle install` installs or updates Homebrew dependencies from `Brewfile`.
- `stow configs/` re-links dotfiles after edits or new config additions.
- `strfile extra_fortunes` recompiles the fortune database after editing `extra_fortunes`.

## Coding Style & Naming Conventions

- Bash scripts use `#!/usr/bin/env bash`; keep steps linear and comment only non-obvious logic.
- Follow existing formatting in `setup.sh` and `update.sh` to keep style consistent.
- Store new dotfiles under `configs/` using the same path they occupy in `$HOME`.

## Testing Guidelines

- No automated tests are defined. Validate changes by running `stow configs/` and checking that symlinks resolve correctly.
- After Brewfile edits, run `brew bundle install` to confirm dependencies install cleanly.
- For fortune updates, re-run `strfile extra_fortunes` and ensure `extra_fortunes.dat` changes.

## Commit & Pull Request Guidelines

- Automated commit messages must be thorough and descriptive.
- PRs should include a brief summary, any manual setup steps, and macOS-specific assumptions.

## Security & Configuration Tips

- Avoid committing machine-specific secrets; use device-specific `.zprofile` entries as described in `README.md`.
- Prefer documenting new dependencies in `Brewfile` rather than ad-hoc install notes.
- Do not store any API keys or secrets in this repository
