#!/bin/bash

CHART=$1; shift
BRANCH=$1; shift
TAG=$1; shift
RELEASE=${BRANCH#*deploy/}

echo "CHART: $CHART"
echo "BRANCH: $BRANCH"
echo "TAG: $TAG"
echo "RELEASE: $RELEASE"

if [[ "$RELEASE" == "$BRANCH" ]]; then
  echo "Not on a deploy/ prefixed branch. Skipping deploy"
  exit 0;
fi

if [[ `env | grep CONFIGURED=false` ]]; then
  echo "Authentication configuration failed. Skipping deployment"
  exit 1;
fi

if [[ `helm list | cut -f1 | grep $RELEASE` ]]; then
  echo "Release '$RELEASE' found. Upgrading app to $TAG"
  UPDATE=true
else
  echo "Release '$RELEASE' not found. Installing at $TAG"
  INSTALL=true
fi

if [[ $UPDATE ]]; then
  CMD="helm upgrade $RELEASE $CHART $@"
  echo "Running '$CMD'"
  $CMD
fi

if [[ $INSTALL ]]; then
  CMD="helm install --name $RELEASE --namespace $RELEASE $CHART $@"
  echo "Running '$CMD'"
  $CMD
fi
