
class dropbox {
  $backup_user = 'backup'
  $backup_dir = '/home/backup'
  $dropbox_daemon = "${backup_dir}/.dropbox-dist/dropboxd"
  $dropbox_admin_name = 'dropbox.py'
  $dropbox_sync_dir = "${backup_dir}/Dropbox"
  user {'dropbox user':
    name => $backup_user,
    ensure => present,
    managehome => true,
    home => $backup_dir
  }
  exec {'download dropbox client':
    command => 'wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -',
    creates => $dropbox_daemon,
    user => $backup_user,
    cwd => $backup_dir,
    path => '/bin:/usr/bin'
  }
  file {'dropbox daemon is executable':
    require => Exec['download dropbox client'],
    path => $dropbox_daemon,
    mode => '0755',
  }
  exec {'download dropbox admin script':
    command => "wget https://www.dropbox.com/download?dl=packages/dropbox.py -O ${dropbox_admin_name}",
    creates => "${backup_dir}/${dropbox_admin_name}",
    user => $backup_user,
    cwd => $backup_dir,
    path => '/bin:/usr/bin'
  }
  file {'dropbox admin script is executable':
    require => Exec['download dropbox admin script'],
    path => "${backup_dir}/${dropbox_admin_name}",
    mode => '0755',
  }
  exec {'start dropbox daemon':
    onlyif => 'false',
    require => File['dropbox daemon is executable'],
    command => "dropboxd &",
    unless => 'ps -C dropbox',
    user => $backup_user,
    cwd => $backup_dir,
    path => "${backup_dir}/.dropbox-dist:/bin:/usr/bin"
  }

}

class {dropbox:
}