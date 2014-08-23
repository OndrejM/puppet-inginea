class origami-inginea-files {
  exec { 'clone origami-inginea github repo':
    command => 'find . -mindepth 1 -delete && git clone https://github.com/OndrejM/origami-prestashop.git . && mv admin admin2812 && chown -R www-data:www-data *',
    cwd => '/var/www/origami.inginea.eu/web',
    creates => '/var/www/origami.inginea.eu/web/admin2812',
    path => '/bin:/usr/bin'
  }
}

class {origami-inginea-files:
}