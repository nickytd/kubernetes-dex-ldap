#!/bin/bash

set -eo pipefail

dir=$(dirname $0)
source $dir/.includes.sh

check_executables


kubectl apply -k $dir

if [ -d $dir/dex/ssl ]; then
  certs=("dex")
  for c in ${certs[@]}; do
    kubectl create secret tls "$c-tls" -n dex \
      --cert=$dir/dex/ssl/tcl.crt \
      --key=$dir/dex/ssl/tcl.key \
      --dry-run=client -o yaml | kubectl apply -f - 
  done 

  kubectl apply -f $dir/dex/ingress.yaml \
      --dry-run=client -o yaml | kubectl apply -f -
fi

