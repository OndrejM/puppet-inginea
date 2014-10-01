class { 'apache':  
  mpm_module => 'prefork'
}

class {'::apache::mod::php':
}

class {'::apache::mod::fcgid':
}

class origami-inginea {
  apache::vhost { 'origami.inginea.eu':
    port    => '80',
    docroot => '/var/www/origami.inginea.eu/web',
    servername => 'origami.inginea.eu',
    serveraliases => ['www.origami.inginea.eu'],
    directories => [
      { 'path' => '/var/www/origami.inginea.eu/web',
        'provider' => 'directory'
      },
      { path => '\.ph(p3?|tml)$',
        provider => 'filesmatch',
        sethandler => 'None'
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

  file {'/var/www/origami.inginea.eu':
    ensure => directory,
    mode   => 0755,
  }

  file {'/var/www/origami.inginea.eu/web':
    ensure => directory,
    mode   => 0755
  }

  file {'/var/www/origami.inginea.eu/web/tmp':
    ensure => directory,
    mode   => 0755
  }
}

class {'origami-inginea':
}

class woocommerce-inginea {
  apache::vhost { 'woocommerce.inginea.eu':
    port    => '80',
    docroot => '/var/www/woocommerce.inginea.eu/web',
    servername => 'woocommerce.inginea.eu',
    serveraliases => ['www.woocommerce.inginea.eu'],
    directories => [
      { 'path' => '/var/www/woocommerce.inginea.eu/web',
        'provider' => 'directory'
      },
      { path => '\.ph(p3?|tml)$',
        provider => 'filesmatch',
        sethandler => 'None'
      }
    ],
    custom_fragment => 'AddType application/x-httpd-php .php .php3 .php4 .php5',
    php_admin_values => [
      'sendmail_path "/usr/sbin/sendmail -t -i -fwebmaster@origami.inginea.eu"',
      'upload_tmp_dir /var/www/woocommerce.inginea.eu/web/tmp',
      'session.save_path /var/www/woocommerce.inginea.eu/web/tmp',
      'open_basedir /var/www/woocommerce.inginea.eu/web:/var/www/woocommerce.inginea.eu/web/private:/var/www/woocommerce.inginea.eu/web/tmp:/srv/www/woocommerce.inginea.eu/web:/usr/share/php5:/usr/share/php:/tmp:/usr/share/phpmyadmin:/etc/phpmyadmin:/var/lib/phpmyadmin'
    ]
  }

  file {'/var/www/woocommerce.inginea.eu':
    ensure => directory,
    mode   => 0755,
  }

  file {'/var/www/woocommerce.inginea.eu/web':
    ensure => directory,
    mode   => 0755
  }

  file {'/var/www/woocommerce.inginea.eu/web/tmp':
    ensure => directory,
    mode   => 0755
  }
}

class {'woocommerce-inginea':
}

class inginea {
  apache::vhost { 'inginea.eu':
    port => '80',
    docroot => '/var/www/inginea.eu/web',
    servername => 'inginea.eu',
    serveraliases => ['www.inginea.eu'],
    directories => [
      { path => '/var/www/inginea.eu/web',
        provider => 'directory'
      },
      { path => '\.ph(p3?|tml)$',
        provider => 'filesmatch',
        sethandler => 'None'
      }
    ]
  }

  file {'/var/www/inginea.eu':
    ensure => directory,
    mode   => 0755,
  }

  file {'/var/www/inginea.eu/web':
    ensure => directory,
    mode   => 0755
  }

}

class {inginea:
}