class {'backupninja':
  ensure => 'present'
}

backupninja::mysql { '11-backup_mysql-server':
  ensure => present,
  compress => no
}

file {'/home/backup/staging/www/inginea/var/www':
  ensure => directory,
  mode   => 0755
}

backupninja::rsync { '12-backup_www_rsync':
  ensure              => 'present',
  mountpoint          => '/home/backup/staging/www',
  backupdir           => 'inginea',
  source_type         => 'local',
  source_include      => 'var/www',
  dest_type           => 'local',
  format              => 'mirror'
}