/*
 * Configuration that begin with number:
 *  1 - backup collection phase (staging)
 *  2 - commiting new version of stage (git)
 *  3 - copy to insync (google drive folder)
 */


$staging_dir_without_start = 'home/backup/staging'
$staging_dir = "/${staging_dir_without_start}"
$insync_dir = '/home/backup/mihalyi@inginea.eu/backup'

class backup_base {

  class {'backupninja':
    ensure => 'present'
  }

}

class backup_mysql {
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
}

class backup_www {
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
}

class backup_init_git_repo {
  exec { 'init git repo in staging dir':
    command => 'git init',
    cwd => $staging_dir,
    creates => "${staging_dir}/.git",
    path => '/bin:/usr/bin'
  }
}

class backup_staging {

  class {'backup_init_git_repo':
  }

  backupninja::sh { '20_git_commit_staging':
    ensure              => 'present',
    command             => template('backupninja_production/git_commit_staging_command.sh.erb')
  }
}

# stages to insync folder, which synchronizes to google drive
class backup_stage_to_insync {
  backupninja::sh { '30_01_ensure_insync_stopped':
    ensure              => 'present',
    command             => "su -c 'insync-headless quit' backup"
  }

  file {[
    "${insync_dir}/gitrepo/home",
    "${insync_dir}/gitrepo/home/backup",
    "${insync_dir}/gitrepo/home/backup/staging"]:
    ensure => directory,
    mode   => 0755,
    owner  => backup,
    group => backup
  }

  backupninja::rsync { '30_02_stage_to_insync':
    ensure              => 'present',
    mountpoint          => $insync_dir,
    backupdir           => 'gitrepo',
    source_type         => 'local',
    source_include      => "${staging_dir_without_start}/.git",
    dest_type           => 'local',
    format              => 'mirror'
  }

  backupninja::sh { '35_insync_owned_by_backup':
    ensure              => 'present',
    command             => "chown backup:backup -R ${insync_dir}"
  }

  backupninja::sh { '39_ensure_insync_running':
    ensure              => 'present',
    command             => "su -c 'insync-headless start' backup"
  }

}

class backup_stage_to_insync_gzipped {
  backupninja::sh { '31_stage_gzipped_to_insync':
    ensure              => 'present',
    when                => 'sunday at 01',
    command             => "tar -zcf ${insync_dir}/gitrepo.tar.gz ${insync_dir}/gitrepo"
  }
}

class backup_ondro_home {
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

class {'backup_base':
}
class {'backup_mysql':
}
class {'backup_www':
}
class {'backup_staging':
}
class {'backup_stage_to_insync':
}
class {'backup_stage_to_insync_gzipped':
}
# not a good idea to backup full home, as many unnecessary files are there
#class {'backup_ondro_home'}

