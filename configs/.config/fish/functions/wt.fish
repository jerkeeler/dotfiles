# Git worktree management with centralized storage
#
# Environment Variables:
#   WT_DIR - Base directory for worktree storage (default: ~/Developer/worktrees/)
#
# Directory Structure:
#   $WT_DIR/<repo-name>/<branch-name>/
#
# Example:
#   ~/Developer/worktrees/
#   ├── dotfiles/
#   │   ├── feature-branch/
#   │   └── bugfix/
#   └── other-repo/
#       └── experiment/

function _wt_get_repo_name --description "Get repository name from remote or directory"
    # Try to get repo name from remote origin URL
    set -l remote_url (git remote get-url origin 2>/dev/null)

    if test -n "$remote_url"
        # Handle SSH format: git@github.com:user/repo-name.git
        # Handle HTTPS format: https://github.com/user/repo-name.git
        set -l repo_name (string replace -r '.*[/:]([^/]+?)(?:\.git)?$' '$1' "$remote_url")
        # Remove .git suffix if still present
        set repo_name (string replace -r '\.git$' '' "$repo_name")
        echo "$repo_name"
    else
        # Fallback to directory name of main worktree
        set -l main_root (git rev-parse --show-toplevel)
        basename "$main_root"
    end
end

function _wt_get_worktree_base --description "Get base path for worktrees"
    set -l wt_dir (set -q WT_DIR; and echo "$WT_DIR"; or echo "$HOME/Developer/worktrees")
    set -l repo_name (_wt_get_repo_name)
    echo "$wt_dir/$repo_name"
end

function wt --description "Git worktree management"
    set -l cmd $argv[1]
    set -l name $argv[2]
    set -l base $argv[3]

    # Verify we're in a git repo
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "wt: not a git repository"
        return 1
    end

    switch $cmd
        case create
            if test -z "$name"
                echo "Usage: wt create <name> [base]"
                return 1
            end

            set -l worktree_base (_wt_get_worktree_base)
            set -l worktree_path "$worktree_base/$name"

            # If worktree already exists, just cd into it
            if test -d "$worktree_path"
                echo "Worktree '$name' already exists, entering..."
                cd "$worktree_path"
                return 0
            end

            # Create worktree base directory if needed
            if not test -d "$worktree_base"
                mkdir -p "$worktree_base"
            end

            # Check if branch already exists
            set -l branch_exists (git show-ref --verify --quiet refs/heads/$name; and echo yes; or echo no)

            if test "$branch_exists" = yes
                # Branch exists, check it out to new worktree
                git worktree add "$worktree_path" "$name"
            else if test -n "$base"
                # Create new branch from base
                git worktree add "$worktree_path" -b "$name" "$base"
            else
                # Create new branch from current HEAD
                git worktree add "$worktree_path" -b "$name"
            end

            and cd "$worktree_path"

        case merge
            if test -z "$name"
                echo "Usage: wt merge <name>"
                return 1
            end

            set -l worktree_base (_wt_get_worktree_base)
            set -l worktree_path "$worktree_base/$name"

            if not test -d "$worktree_path"
                echo "wt: worktree '$name' not found"
                return 1
            end

            # Merge with ff-only
            if not git merge --ff-only "$name"
                echo "wt: merge failed (not fast-forward)"
                return 1
            end

            # Remove worktree and branch
            git worktree remove "$worktree_path"
            and git branch -d "$name"
            and echo "Merged and cleaned up '$name'"

        case ls
            git worktree list

        case cd
            if test -z "$name"
                echo "Usage: wt cd <name>"
                return 1
            end

            set -l worktree_base (_wt_get_worktree_base)
            set -l worktree_path "$worktree_base/$name"

            if not test -d "$worktree_path"
                echo "wt: worktree '$name' not found"
                return 1
            end

            cd "$worktree_path"

        case root
            # Go to the main worktree (the original clone, not in $WT_DIR)
            set -l main_root (dirname (realpath (git rev-parse --git-common-dir)))
            cd "$main_root"

        case rm
            if test -z "$name"
                echo "Usage: wt rm <name>"
                return 1
            end

            set -l worktree_base (_wt_get_worktree_base)
            set -l worktree_path "$worktree_base/$name"

            if not test -d "$worktree_path"
                echo "wt: worktree '$name' not found"
                return 1
            end

            git worktree remove "$worktree_path"
            and git branch -D "$name"
            and echo "Removed worktree and branch '$name'"

        case '*'
            echo "Usage: wt <command> [args]"
            echo ""
            echo "Commands:"
            echo "  create <name> [base]  Create worktree and cd into it"
            echo "  cd <name>             Change to worktree directory"
            echo "  root                  Go to main worktree root"
            echo "  merge <name>          Merge worktree (ff-only) and clean up"
            echo "  ls                    List all worktrees"
            echo "  rm <name>             Remove worktree without merging"
            echo ""
            echo "Environment:"
            echo "  WT_DIR                Worktree storage location (default: ~/Developer/worktrees/)"
            return 1
    end
end
