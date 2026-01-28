# Octo.nvim Code Review Guide

A quick reference for performing GitHub PR reviews in Neovim using Octo.

## Setup

Your localleader is `\` (backslash). All Octo mappings use localleader.

## Opening a PR

```vim
:Octo pr list              " Browse PRs in current repo (uses fzf-lua)
:Octo pr <number>          " Open specific PR directly
```

## Starting a Review

```vim
:Octo review start         " Begin a new review
:Octo review resume        " Resume a saved review
:Octo review discard       " Discard review and all pending comments
:Octo review close         " Save review for later (keeps pending comments)
```

## Navigating Changed Files

| Key | Action |
|-----|--------|
| `:Octo changes` | Open file picker for changed files |
| `]q` / `[q` | Next/previous changed file |
| `]Q` / `[Q` | First/last changed file |
| `]u` / `[u` | Next/previous unviewed file |
| `\e` | Focus the changed files panel |
| `\b` | Toggle files panel visibility |

## Marking Files as Viewed

| Key | Action |
|-----|--------|
| `\<space>` | Toggle file viewed status (the green checkmark) |

## Adding Comments

Position cursor on the line you want to comment on:

| Key | Action |
|-----|--------|
| `\ca` | Add a review comment |
| `\sa` | Add a suggestion (code change the author can apply) |

For multi-line comments, visually select lines first (`V` to select), then use the same mappings.

## Navigating Comments/Threads

| Key | Action |
|-----|--------|
| `]t` / `[t` | Next/previous comment thread |

## Submitting the Review

```vim
:Octo review submit
```

A float window appears. Write your summary, then:
- `<C-m>` - Submit as comment (neutral feedback)
- `<C-a>` - Approve the PR
- `<C-r>` - Request changes

## Reactions

| Key | Reaction |
|-----|----------|
| `\r+` | thumbs up |
| `\r-` | thumbs down |
| `\rp` | party |
| `\rh` | heart |
| `\re` | eyes |
| `\rr` | rocket |
| `\rl` | laugh |
| `\rc` | confused |

## Quick Workflow Summary

```
:Octo pr <number>          1. Open the PR
:Octo review start         2. Start review mode
:Octo changes              3. Browse changed files
\<space>                   4. Mark files as viewed
\ca                        5. Add comments where needed
:Octo review submit        6. Submit with verdict (C-a to approve)
```

## Saving and Resuming

If you need to step away:
```vim
:Octo review close         " Saves pending comments
```

Later:
```vim
:Octo pr <number>
:Octo review resume        " Pick up where you left off
```

## Notes

- Octo uses split diffs only (no unified view option)
- Comments are stored on GitHub until you submit or discard
- Use `:Octo actions` to see all available commands in context
