#!/bin/bash

# if we get an error bail
set -euxo pipefail

if [ -z "$1" ]; then
    echo Usage ${0}: version
    echo       for example:
    echo
    echo       ${0} 2.0.0000-beta0
    echo
    exit
fi

rm -rf build

if [ -z "$(git status --porcelain)" ]; then
    echo 'git status is clean'
else
    echo 'uncommitted changes, run `git status` for more information'
    exit
fi

if [ "$(git symbolic-ref --short HEAD)" != "master" ]; then
    echo 'will only deploy from master branch, bailing'
    echo 'uncomment before committing'
    #exit
fi

if [ -z "$(git tag | grep ${1})" ]; then
    echo "git tag is clean"
else
    echo "the tag ${1} already exists, bailing"
    exit
fi

PROD_BRANCH="production-$(date +"%Y%m%d-%s")"
git checkout -b $PROD_BRANCH

./scripts/build_xcframework.sh

./scripts/copy_archive_and_package.sh ${PROD_BRANCH} ${PROD_BRANCH}

./scripts/run_xcframework_test.sh ${PROD_BRANCH} "https://github.com/getbouncer/cardscan-ios.git"

git checkout .

# we're all done, copy the prod archive and tag the prod branch
./scripts/copy_archive_and_package.sh ${PROD_BRANCH} ${1}

# one last test
./scripts/run_xcframework_test.sh ${PROD_BRANCH} "https://github.com/getbouncer/cardscan-ios.git"

git checkout .

# Success tag the branch and we're done
echo "xcarchive deployed successfully and tested, tagging branch"

git tag ${1}
git push origin ${PROD_BRANCH} --tags