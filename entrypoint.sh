#!/bin/sh -lx

BRANCH_NAME=${GITHUB_REF##refs/heads/}
CURRENT_VERSION=`git-semv now --url "$GITHUB_ACTION_REPOSITORY" 2>/dev/null`
[ "${CURRENT_VERSION}" == "" ] && git-semv minor --url "$GITHUB_ACTION_REPOSITORY"  && exit 0

[[ "$BRANCH_NAME" == "master" ]] && git-semv minor --url "$GITHUB_ACTION_REPOSITORY"
[[ "$BRANCH_NAME" == "develop" ]] && git-semv minor --url "$GITHUB_ACTION_REPOSITORY" --pre-name dev
[[ "$BRANCH_NAME" == "feature"* ]] && git-semv minor --url "$GITHUB_ACTION_REPOSITORY" --pre-name feature
[[ "$BRANCH_NAME" == "hotfix"* ]] && echo -n $(git-semv now --url "$GITHUB_ACTION_REPOSITORY")-hotfix
exit 0
