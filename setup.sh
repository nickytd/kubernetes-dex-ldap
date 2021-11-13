#!/bin/bash

set -eo pipefail

dir=$(dirname $0)
source $dir/.includes.sh

check_executables

kubectl apply -k $dir

kubectl apply -f $dir/dex/ingress.yaml \
  --dry-run=client -o yaml | kubectl apply -f -


