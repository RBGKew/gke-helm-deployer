#!/bin/bash

configured=true

if [ -z ${G_USER+x} ]; then
  echo "WARNING: G_USER not set"
  configured=false
fi

if [ -z ${G_PROJECT+x} ]; then
  echo "WARNING: G_PROJECT not set"
  configured=false
fi

if [ -z ${G_CLUSTER+x} ]; then 
  echo "WARNING: G_CLUSTER not set"
  configured=false
fi

if [ -z ${G_REGION+x} ]; then
  echo "WARNING: G_REGION not set"
  configured=false
fi

if [ -z ${G_ZONE+x} ]; then
  echo "WARNING: G_ZONE not set"
  configured=false
fi

if [ "$configured" = true ]; then
  gcloud auth activate-service-account $G_USER --key-file $GOOGLE_APPLICATION_CREDENTIALS
  gcloud config set project $G_PROJECT
  gcloud config set container/cluster $G_CLUSTER
  gcloud config set compute/region $G_REGION
  gcloud config set compute/zone $G_ZONE
  gcloud container clusters get-credentials $G_CLUSTER
else
  echo "Not attempting to configure gcloud credentials"
fi

exec $@;
