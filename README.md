puppet-inginea
==============

Puppet configuration of inginea server

Root of this repository is /etc/puppet

To configure system with puppet, execute (will download missing modules and update system according to manifests):

    bin/update_system.sh

For only downloading missing modules, execute:

    bin/install_modules.sh
    

Versioned common local modules are in localmodules folder and they are globally included to all configurations.

TODO:
 - backup
  - add rsync configuration to copy mysql dumps into staging directory
  - add sh configuration support to backupninja
  - configure sh backup to create a new git version from staging directory
  - push git repository to Dropbox folder
    - uncompressed - only changed files should be transferred
    - once a week a compressed version to prevent possible errors in transfer to Dropbox