#!/bin/bash
set -eu

# REPOSITORY TO CHECK FOR NEW TAG
REPO_OWNER="pnpm"
REPO_NAME="pnpm"

# GET THE LATEST RELEASE OF THE REPO
RELEASE=$(wget -qO- "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest")

# GET THE TAG NAME AS WE USE IT FOR OUR OWN TAGS
VERSION=$(echo $RELEASE | jq -r '.tag_name')

TAG_NAME=pnpm$(echo $VERSION | cut -dv -f2)
# CHECK IF WE ALREADY BUILD THE TAG
if [ $(git tag -l "$TAG_NAME") ]; then
  echo "Tag version exists in our repo, nothing to do"
else
  echo "Found a new version: $VERSION. Tagging this repository to trigger rebuild"
  git tag $TAG_NAME
  git push origin $TAG_NAME
fi
