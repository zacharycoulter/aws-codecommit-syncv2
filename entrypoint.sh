#!/bin/sh

set -ue

RepositoryName="${INPUT_REPOSITORY_NAME}"
AwsRegion="${INPUT_AWS_REGION}"
Branch="${INPUT_BRANCH}"
CodeCommitUrl="https://git-codecommit.${AwsRegion}.amazonaws.com/v1/repos/${RepositoryName}"
git config --global --add safe.directory /github/workspace
git config --global credential.'https://git-codecommit.*.amazonaws.com'.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
aws sts get-caller-identity --query "Account"
git remote add sync ${CodeCommitUrl}
git gc
git fsck
git prune
git repack
git fsck
git pull origin ${Branch}
chmod 777 -Rf ./*
git push sync ${Branch} --force
