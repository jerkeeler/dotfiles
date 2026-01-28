function gco_remote --description 'Fetch a specific remote branch explicitly and checkout' --argument branch_name
    # 1. Validate input
    if test -z "$branch_name"
        echo "Usage: gco_remote <branch_name>"
        return 1
    end

    # 2. Check if we already have this branch locally
    if git show-ref --verify --quiet "refs/heads/$branch_name"
        echo "✅ Local branch '$branch_name' already exists. Switching..."
        git checkout "$branch_name"
        # Optional: Pull to ensure it's up to date
        git pull origin "$branch_name"
        return $status
    end

    echo "🎣 Fetching origin/$branch_name..."

    # 3. Fetch ONLY the requested branch to refs/remotes/origin/
    # The + prefix allows non-fast-forward updates (e.g., rebased branches)
    git fetch origin "+$branch_name:refs/remotes/origin/$branch_name"

    if test $status -eq 0
        echo "✅ Fetch complete. Creating local branch..."

        # 4. EXPLICITLY create the branch pointing to the remote ref
        # This bypasses the "pathspec" error by telling Git exactly where the commit is
        git checkout -b "$branch_name" "origin/$branch_name"
    else
        echo "❌ Error: Could not fetch branch '$branch_name'. Check the spelling or remote."
    end
end
