#!/bin/bash

. $(dirname $0)/install_modules.sh

if [[ WITH_CHECK_$1 = WITH_CHECK_-c ]]; then 
  puppet apply --noop --verbose /etc/puppet/environments/production/manifests  # NOOP - PREVIEW CHANGES 
  if [[ OK_$? = OK_0 ]]; then
    echo Puppet check OK
    echo Press ENTER to continue to APPLY changes
    read
  else
    echo Puppet CHECK finished with ERRORS - will not continue to APPLY changesa
    exit
  fi
fi
puppet apply --verbose /etc/puppet/environments/production/manifests  # UPDATE SYSTEM
