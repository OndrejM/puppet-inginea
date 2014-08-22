puppet-inginea
==============

Puppet configuration of inginea server

Root of this repository is /etc/puppet

To configure puppet, execute:

    # updates external modules (downlaods which are missing)
    bin/install_modules.sh
    
    # updates system according to manifests
    sudo puppet apply manifests
