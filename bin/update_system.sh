#!/bin/sh

. $(dirname $0)/install_modules.sh

puppet apply --verbose /etc/puppet/environments/production/manifests  # UPDATE SYSTEM
#puppet apply --verbose /etc/puppet/environments/production/manifests  # NOOP - PREVIEW CHANGES
