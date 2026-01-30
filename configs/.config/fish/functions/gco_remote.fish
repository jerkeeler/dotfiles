function gco_remote --description 'Checkout a local branch as an exact copy of the remote' --argument branch_name
    # Checks out a local branch that is an exact copy of the remote branch on GitHub.
    # If the local branch exists, it is force-updated to match the remote exactly.
    # If the local branch doesn't exist, it is created from the remote.
    # This is useful for reviewing PRs or syncing with force-pushed/rebased branches.

    # 1. Validate input
    if test -z "$branch_name"
        echo "Usage: gco_remote <branch_name>"
        return 1
    end

    echo "🎣 Fetching origin/$branch_name..."

    # 2. Fetch the requested branch from origin
    # The + prefix allows non-fast-forward updates (e.g., rebased branches)
    git fetch origin "+$branch_name:refs/remotes/origin/$branch_name"

    if test $status -ne 0
        echo "❌ Error: Could not fetch branch '$branch_name'. Check the spelling or remote."
        return 1
    end

    echo "✅ Fetch complete."

    # 3. Check if local branch exists and handle accordingly
    if git show-ref --verify --quiet "refs/heads/$branch_name"
        echo "🔄 Local branch exists. Force-updating to match remote..."
        git checkout "$branch_name"
        git reset --hard "origin/$branch_name"
    else
        echo "✨ Creating local branch from remote..."
        git checkout -b "$branch_name" "origin/$branch_name"
    end
end
