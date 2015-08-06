#!/bin/bash

. $(dirname $0)/install_modules.sh

puppet apply --noop --verbose /etc/puppet/environments/production/manifests  # NOOP - PREVIEW CHANGES 
if [[ OK_$? = OK_0 ]]; then
  echo Puppet check OK
  echo Press ENTER to continue to APPLY changes
  read
  puppet apply --verbose /etc/puppet/environments/production/manifests  # UPDATE SYSTEM
else
  echo Puppet CHECK finished with ERRORS - will not continue to APPLY changes
fi
