#!/bin/bash

echo "Deploying web app"

flutter build web


# Read the BRANCH_NAME from git
echo "Getting current branch name"
BRANCH_NAME=$(git branch --show-current)

# Convert branch name to lowercase and replace slashes with underscores
BRANCH_PATH=$(echo $BRANCH_NAME | tr '[:upper:]' '[:lower:]' | tr -d '.')


if [ -n "$BRANCH_PATH" ]; then
    
    # Read the PATH_TO_WEB_REPOSITORY from the environment file
    echo "Getting path of web project from env file"
    PATH_TO_WEB_REPOSITORY="../releases"
    
    echo "Creating folders for branch: $BRANCH_PATH"
    DEPLOY_PATH="$PATH_TO_WEB_REPOSITORY/$BRANCH_PATH"
    echo "Creating folders for branch: $BRANCH_PATH at $DEPLOY_PATH"

    mkdir -p $DEPLOY_PATH
    echo "Copying the files..."
    cp -R ./build/web/ $DEPLOY_PATH
    cp -R ./web/app.html $DEPLOY_PATH


else
    echo "Error: Unable to determine the current branch name."
fi





