#!/bin/sh -l

[ -z ${1+x} ] && echo "You should provide the branch name as argument" && exit 1
BRANCH_NAME="${1}"

printenv
ls -lah
pwd

[ ! -d "/repo" ] && echo "The git repository should be available at /repo" && exit 1
cd /repo

ls -lah

echo "get current version"
CURRENT_VERSION=`git-semv now 2>/dev/null`

echo "check current version not empty"
[ "${CURRENT_VERSION}" == "" ] && git-semv minor && exit 0

[[ "$BRANCH_NAME" == "master" ]] && git-semv minor
[[ "$BRANCH_NAME" == "develop" ]] && git-semv minor --pre-name dev
[[ "$BRANCH_NAME" == "feature"* ]] && git-semv minor --pre-name feature
[[ "$BRANCH_NAME" == "hotfix"* ]] && echo -n $(git semv now)-hotfix
