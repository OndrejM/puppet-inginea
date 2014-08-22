#!/bin/sh

. $(dirname $0)/install_modules.sh

puppet apply --verbose /etc/puppet/environments/production/manifests
