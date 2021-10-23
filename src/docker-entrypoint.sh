#!/bin/sh

set -euo pipefail

export PDNS_local_port PDNS_local_address PDNS_allow_from

if [ -f /etc/fedora-release ]; then
  config_file=/etc/pdns-recursor/recursor.conf
  pdns_user=pdns-recursor
elif [ -f /etc/alpine-release ]; then
  config_file=/etc/pdns/recursor.conf
  pdns_user=recursor
fi

# Fix config file ownership
chown ${pdns_user}: $config_file



exec "$@"
