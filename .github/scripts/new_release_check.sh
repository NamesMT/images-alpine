#!/bin/bash
set -eu

# REPOSITORY TO CHECK FOR NEW TAG
REPO_OWNER="pnpm"
REPO_NAME="pnpm"

# GET THE LATEST RELEASE OF THE REPO
RELEASE=$(wget -qO- "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest")

# GET THE TAG NAME AS WE USE IT FOR OUR OWN TAGS
VERSION=$(echo $RELEASE | jq -r '.name')

# EXTRACT THE DATE OF THE RELEASE AND MAKE IT A TIMESTAMP
TIMESTAMP=$(echo $RELEASE | jq -r '.published_at' | date -f - +%s)
# GET THE CURRENT TIME
CURRENT_TIMESTAMP=$(date +%s)
# AND SUBTRACT 24 HOURS AS WE CHECK 1 TIME PER DAY
TIMESTAMP_24_HOURS_AGO=$((CURRENT_TIMESTAMP - 86400))

# CHECK IF WE ALREADY BUILD THE TAG
if [ $(git tag -l "$VERSION") ]; then
  echo "Tag version exists in our repo, nothing to do"
else
  echo "Found a new version: $VERSION. Tagging this repository to trigger rebuild"
  TAG_NAME=pnpm$(echo $VERSION | cut -dv -f2)
  git tag $TAG_NAME
  git push origin $TAG_NAME
fi
