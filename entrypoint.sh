#!/bin/sh -l

BRANCH_NAME=${GITHUB_REF##refs/heads/}

CURRENT_VERSION=`git-semv now --url "$GITHUB_REPOSITORY" 2>/dev/null`

echo "::set-output name=CURRENT_VERSION::${CURRENT_VERSION}"

[[ "${CURRENT_VERSION}" == "" ]] && NEXT_VERSION=`git-semv minor --url "$GITHUB_REPOSITORY"` && echo "::set-output name=NEXT_VERSION::${NEXT_VERSION}" && exit 0

[[ "$BRANCH_NAME" == "master" ]] &&  NEXT_VERSION=`git-semv minor --url "$GITHUB_REPOSITORY"`
[[ "$BRANCH_NAME" == "develop" ]] &&  NEXT_VERSION=`git-semv minor --url "$GITHUB_REPOSITORY" --pre-name dev`
[[ "$BRANCH_NAME" == "feature"* ]] &&  NEXT_VERSION=`git-semv minor --url "$GITHUB_REPOSITORY" --pre-name feature`
[[ "$BRANCH_NAME" == "hotfix"* ]] &&  NEXT_VERSION=`git-semv now --url "$GITHUB_REPOSITORY"`-hotfix

echo "::set-output name=NEXT_VERSION::${NEXT_VERSION}"

exit 0
