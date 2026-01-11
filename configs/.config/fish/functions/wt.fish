function wt --description "Git worktree management"
    set -l cmd $argv[1]
    set -l name $argv[2]
    set -l base $argv[3]
    set -l worktree_dir ".worktrees"

    # Verify we're in a git repo
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "wt: not a git repository"
        return 1
    end

    # Get repo root
    set -l repo_root (git rev-parse --show-toplevel)

    switch $cmd
        case create
            if test -z "$name"
                echo "Usage: wt create <name> [base]"
                return 1
            end

            set -l worktree_path "$repo_root/$worktree_dir/$name"

            # If worktree already exists, just cd into it
            if test -d "$worktree_path"
                echo "Worktree '$name' already exists, entering..."
                cd "$worktree_path"
                return 0
            end

            # Create .worktrees directory if needed
            if not test -d "$repo_root/$worktree_dir"
                mkdir -p "$repo_root/$worktree_dir"
            end

            # Create worktree with new branch
            if test -n "$base"
                git worktree add "$worktree_path" -b "$name" "$base"
            else
                git worktree add "$worktree_path" -b "$name"
            end

            and cd "$worktree_path"

        case merge
            if test -z "$name"
                echo "Usage: wt merge <name>"
                return 1
            end

            set -l worktree_path "$repo_root/$worktree_dir/$name"

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

            set -l worktree_path "$repo_root/$worktree_dir/$name"

            if not test -d "$worktree_path"
                echo "wt: worktree '$name' not found"
                return 1
            end

            cd "$worktree_path"

        case rm
            if test -z "$name"
                echo "Usage: wt rm <name>"
                return 1
            end

            set -l worktree_path "$repo_root/$worktree_dir/$name"

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
            echo "  merge <name>          Merge worktree (ff-only) and clean up"
            echo "  ls                    List all worktrees"
            echo "  rm <name>             Remove worktree without merging"
            return 1
    end
end
