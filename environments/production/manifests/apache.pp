class { 'apache':  
  mpm_module => 'prefork'
}

class {'::apache::mod::php':
}

apache::vhost { 'origami.inginea.eu':
  port    => '80',
  docroot => '/var/www/origami.inginea.eu/web',
  servername => 'origami.inginea.eu',
  serveraliases => ['www.origami.inginea.eu'],
  directories => [
    { 'path' => '/var/www/origami.inginea.eu/web',
      'provider' => 'direcotry',
      'auth_require' => 'all granted' 
    },
    { 'path' => '/var/www/origami.inginea.eu/web',
      'provider' => 'direcotry',
      'auth_require' => 'all granted' 
    }
  ],
  custom_fragment => 'AddType application/x-httpd-php .php .php3 .php4 .php5',
  php_admin_values => [
    'sendmail_path "/usr/sbin/sendmail -t -i -fwebmaster@origami.inginea.eu"',
    'upload_tmp_dir /var/www/origami.inginea.eu/web/tmp',
    'session.save_path /var/www/origami.inginea.eu/web/tmp',
    'open_basedir /var/www/origami.inginea.eu/web:/var/www/origami.inginea.eu/web/private:/var/www/origami.inginea.eu/web/tmp:/srv/www/origami.inginea.eu/web:/usr/share/php5:/usr/share/php:/tmp:/usr/share/phpmyadmin:/etc/phpmyadmin:/var/lib/phpmyadmin'
  ]
}

