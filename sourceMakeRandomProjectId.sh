#!/bin/bash

(return 0 2>/dev/null) && sourced=1 || sourced=0
if [ $sourced -eq 0 ]; then
  echo "ERROR, this script is meant to be sourced."
  exit 1
fi

# random GCP project id
export TF_VAR_project=myproj-$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w22 | head -n1)

# set as variable for terraform 'TF_VAR_' prefix
echo "TF_VAR_project=$TF_VAR_project"
