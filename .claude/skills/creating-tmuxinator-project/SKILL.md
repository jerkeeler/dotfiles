---
name: creating-tmuxinator-project
description: Use when creating a new tmuxinator project configuration
---

# Creating Tmuxinator Projects

## Workflow

1. **Ask for project name** using AskUserQuestion
2. **Ask for project folder path** using AskUserQuestion
3. **Validate folder exists** using Bash `test -d <path>`
4. If folder does not exist, inform user and ask for a valid path
5. Create config file at `~/.config/tmuxinator/<project-name>.yml`

## Template

```yaml
name: <project-name>
root: <project-root-path>

on_project_start: printf '\033]0;mux <project-name>\007'

windows:
  - editor:
      layout: main-vertical
      panes:
        - vim
        -
  - claude: claude
```

## Key Elements

- **on_project_start**: Sets terminal title to `mux <project-name>`
- **editor window**: main-vertical layout with vim in main pane, empty side pane
- **claude window**: Runs claude command

## Adding Project-Specific Windows

Add additional windows after `claude` as needed:

```yaml
  - server: npm run dev
  - logs: tail -f logs/app.log
```
