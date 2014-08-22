include git

git::config { 'user.name':
  value => 'Ondrej Mihalyi',
}

git::config { 'user.email':
  value => 'ondrej.mihalyi@gmail.com',
}


exec { 'clone github repo':
  command => 'find . -mindepth 1 -delete && git clone https://github.com/OndrejM/origami-prestashop.git . && mv admin admin2812 && chown -R www-data:www-data *',
  cwd => '/var/www/origami.inginea.eu/web',
  creates => '/var/www/origami.inginea.eu/web/admin2812',
  require => File['/var/www/origami.inginea.eu/web'],
  path => '/bin:/usr/bin'
}