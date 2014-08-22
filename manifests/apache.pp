class { 'apache':  }

apache::vhost { 'origami.inginea.eu':
  port    => '80',
  docroot => '/var/www/origami.inginea.eu/web',
}

