#!/bin/sh -l

BRANCH_NAME=${GITHUB_REF##refs/heads/}

for var in `printenv |grep GITHUB`
do
  VAR_NAME=`echo $var |awk -F'=' '{print $1}'`
  VAR_VALUE=`echo $var |awk -F'=' '{print $2}'`
  echo "::set-output name=${VAR_NAME}::${VAR_VALUE}"
done

CURRENT_VERSION=`git-semv now --url "$GITHUB_REPOSITORY" 2>/dev/null`

echo "::set-output name=CURRENT_VERSION::${CURRENT_VERSION}"

[[ "${CURRENT_VERSION}" == "" ]] && NEXT_VERSION=`git-semv minor --url "$GITHUB_REPOSITORY"` && echo "::set-output name=NEXT_VERSION::${NEXT_VERSION}" && exit 0

[[ "$BRANCH_NAME" == "master" ]] &&  NEXT_VERSION=`git-semv minor --url "$GITHUB_REPOSITORY"`
[[ "$BRANCH_NAME" == "develop" ]] &&  NEXT_VERSION=`git-semv minor --url "$GITHUB_REPOSITORY" --pre-name dev`
[[ "$BRANCH_NAME" == "feature"* ]] &&  NEXT_VERSION=`git-semv minor --url "$GITHUB_REPOSITORY" --pre-name feature`
[[ "$BRANCH_NAME" == "hotfix"* ]] &&  NEXT_VERSION=`git-semv now --url "$GITHUB_REPOSITORY"`-hotfix

echo "::set-output name=NEXT_VERSION::${NEXT_VERSION}"

exit 0
