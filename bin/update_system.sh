#!/bin/sh

. $(dirname $0)/install_modules.sh

puppet apply /etc/puppet/manifests
