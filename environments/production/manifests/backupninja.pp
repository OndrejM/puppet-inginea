class {'backupninja':
  ensure => 'present'
}

class backup {

  $staging_dir = '/home/backup/staging'

  backupninja::mysql { '11_backup_mysql_server':
    ensure => present,
    compress => no
  }

  file {[
    "${staging_dir}/mysql/var",
    "${staging_dir}/mysql/var/backups",
    "${staging_dir}/mysql/var/backups/mysql",
    "${staging_dir}/mysql/var/backups/mysql/sqldump"]:
    ensure => directory,
    mode   => 0755,
    owner  => backup,
    group => backup
  }

  backupninja::rsync { '12_stage_mysql_backups':
    ensure              => 'present',
    mountpoint          => $staging_dir,
    backupdir           => 'mysql',
    source_type         => 'local',
    source_include      => 'var/backups/mysql/sqldump',
    dest_type           => 'local',
    format              => 'mirror'
  }

  file {[
    "${staging_dir}/www/var",
    "${staging_dir}/www/var/www"]:
    ensure => directory,
    mode   => 0755,
    owner  => backup,
    group => backup
  }

  backupninja::rsync { '13_backup_www_rsync':
    ensure              => 'present',
    mountpoint          => $staging_dir,
    backupdir           => 'www',
    source_type         => 'local',
    source_include      => 'var/www',
    source_exclude      => '.git',
    dest_type           => 'local',
    format              => 'mirror'
  }

  exec { 'init git repo in staging dir':
    command => 'git init',
    cwd => $staging_dir,
    creates => "${staging_dir}/.git",
    path => '/bin:/usr/bin'
  }

  backupninja::sh { '20_git_commit_staging':
    ensure              => 'present',
    command             => template('backupninja_production/git_commit_staging_command.sh.erb')
  }

  file {[
    "${staging_dir}/ondro/home",
    "${staging_dir}/ondro/home/ondro"]:
    ensure => directory,
    mode   => 0755,
    owner  => backup,
    group => backup
  }

  backupninja::rsync { '14_backup_home_ondro':
    ensure              => 'present',
    mountpoint          => $staging_dir,
    backupdir           => 'ondro',
    source_type         => 'local',
    source_include      => 'home/ondro',
    source_exclude      => '.git',
    dest_type           => 'local',
    format              => 'mirror'
  }  

}

class {'backup':
}
