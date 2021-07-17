#!/bin/sh -lx

echo "at least iam there"
BRANCH_NAME=${GITHUB_REF##refs/heads/}
echo BRANCH_NAME is $BRANCH_NAME

CURRENT_VERSION=`git-semv now --url "$GITHUB_ACTION_REPOSITORY" 2>/dev/null`

echo CURRENT_VERSION is $CURRENT_VERSION
echo here we go

[ "${CURRENT_VERSION}" == "" ] && git-semv minor --url "$GITHUB_ACTION_REPOSITORY"  && exit 0

[[ "$BRANCH_NAME" == "master" ]] && git-semv minor --url "$GITHUB_ACTION_REPOSITORY"
[[ "$BRANCH_NAME" == "develop" ]] && git-semv minor --url "$GITHUB_ACTION_REPOSITORY" --pre-name dev
[[ "$BRANCH_NAME" == "feature"* ]] && git-semv minor --url "$GITHUB_ACTION_REPOSITORY" --pre-name feature
[[ "$BRANCH_NAME" == "hotfix"* ]] && echo -n $(git-semv now --url "$GITHUB_ACTION_REPOSITORY")-hotfix
