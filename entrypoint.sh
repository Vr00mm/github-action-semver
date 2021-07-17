#!/bin/sh -l

pwd
tree /github

BRANCH_NAME=${GITHUB_REF##refs/heads/}

echo "get current version"
CURRENT_VERSION=`git-semv now 2>/dev/null`

echo "check current version not empty"
[ "${CURRENT_VERSION}" == "" ] && git-semv minor && exit 0

[[ "$BRANCH_NAME" == "master" ]] && git-semv minor
[[ "$BRANCH_NAME" == "develop" ]] && git-semv minor --pre-name dev
[[ "$BRANCH_NAME" == "feature"* ]] && git-semv minor --pre-name feature
[[ "$BRANCH_NAME" == "hotfix"* ]] && echo -n $(git semv now)-hotfix
