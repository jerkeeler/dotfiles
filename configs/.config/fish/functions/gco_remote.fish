function gco_remote --description 'Fetch a specific remote branch explicitly and checkout' --argument branch_name
    # 1. Validate input
    if test -z "$branch_name"
        echo "Usage: gco_remote <branch_name>"
        return 1
    end

    echo "🎣 Fetching origin/$branch_name..."

    # 2. Fetch ONLY the requested branch
    # This bypasses the strict fetch refspec in your .git/config
    git fetch origin "$branch_name":"refs/remotes/origin/$branch_name"

    if test $status -eq 0
        echo "✅ Fetch complete. Checking out..."

        # 3. Checkout the branch
        # Git now knows about this specific ref because we just fetched it
        git checkout "$branch_name"
    else
        echo "❌ Error: Could not fetch branch '$branch_name'. Check the spelling or remote."
    end
end
