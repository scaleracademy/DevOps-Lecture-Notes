#!/bin/bash

# Function to check the exit status of the last command
check_error() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed!" >&2
        echo "$(date) - Error: $1 failed!" >> git_sync.log
        return 1  # Instead of exiting, return an error code
    fi
}

# Create a new branch for the changes
BRANCH_NAME="auto-sync-$(date +%Y%m%d%H%M%S)"
echo "$(date) - Creating branch $BRANCH_NAME" >> git_sync.log
git checkout -b $BRANCH_NAME
check_error "Git branch creation"

# Pull latest changes from the main branch
echo "$(date) - Pulling latest changes" >> git_sync.log
git pull origin main
check_error "Git pull"

# Add changes to Git
echo "$(date) - Adding changes" >> git_sync.log
git add .
check_error "Git add"

# Commit changes with a generic message
echo "$(date) - Committing changes" >> git_sync.log
git commit -m "Auto-sync changes at $(date)"
check_error "Git commit"

# Push the new branch
echo "$(date) - Pushing new branch $BRANCH_NAME" >> git_sync.log
git push origin $BRANCH_NAME
check_error "Git push"

# Switch back to main and merge the new branch
echo "$(date) - Switching to main branch" >> git_sync.log
git checkout main
check_error "Git checkout main"
git pull origin main
check_error "Git pull main"
git merge $BRANCH_NAME
check_error "Git merge"

echo "$(date) - Pushing merged changes to main" >> git_sync.log
git push origin main
check_error "Git push main"

# Delete the temporary branch
echo "$(date) - Deleting temporary branch $BRANCH_NAME" >> git_sync.log
git branch -d $BRANCH_NAME
check_error "Git branch delete"
git push origin --delete $BRANCH_NAME
check_error "Git remote branch delete"


echo "$(date) - Git sync completed successfully!" >> git_sync.log
echo "Git sync completed successfully!"
