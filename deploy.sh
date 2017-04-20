#!/usr/bin/env bash

#git worktree add -b master public origin/master

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${DIR}"
hugo

cd "${DIR}/public"
touch .nojekyll
echo "redhatgov.io" > CNAME

git add .
git commit -m "Site generation"

git push
