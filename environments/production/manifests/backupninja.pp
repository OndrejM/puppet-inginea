class {'backupninja':
  ensure => 'present'
}

backupninja::mysql { '11_backup_mysql_server':
  ensure => present,
  compress => no
}

file {[
  '/home/backup/staging/mysql/var',
  '/home/backup/staging/mysql/var/backups',
  '/home/backup/staging/mysql/var/backups/mysql',
  '/home/backup/staging/mysql/var/backups/mysql/sqldump']:
  ensure => directory,
  mode   => 0755,
  owner  => backup,
  group => backup
}

backupninja::rsync { '12_stage_mysql_backups':
  ensure              => 'present',
  mountpoint          => '/home/backup/staging',
  backupdir           => 'mysql',
  source_type         => 'local',
  source_include      => 'var/backups/mysql/sqldump',
  dest_type           => 'local',
  format              => 'mirror'
}

file {[
  '/home/backup/staging/www/var',
  '/home/backup/staging/www/var/www']:
  ensure => directory,
  mode   => 0755,
  owner  => backup,
  group => backup
}

backupninja::rsync { '13_backup_www_rsync':
  ensure              => 'present',
  mountpoint          => '/home/backup/staging',
  backupdir           => 'www',
  source_type         => 'local',
  source_include      => 'var/www',
  dest_type           => 'local',
  format              => 'mirror'
}

backupninja::sh { '20_git_commit_staging':
  ensure              => 'present',
  command             => template('backupninja_production/git_commit_staging_command.sh.erb')
}
