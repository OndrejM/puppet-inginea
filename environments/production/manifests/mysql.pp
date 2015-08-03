$my_cfg__options = {
  client => {
    user => 'root@localhost',
    password => 12345,
    host => '127.0.0.1'
  }
}

class { '::mysql::server':
old_root_password => '12345',
root_password => '12345',
override_options => $my_cfg_options

}

class {'mysql::bindings':
	php_enable => true
}

class woocommerce-mysql {
mysql_database { 'wordpress':
  ensure  => 'present',
  charset => 'utf8',
  collate => 'utf8_czech_ci',
}
    mysql_user { 'wordpress@localhost':
	ensure  => 'present',
  password_hash   => '*C2A65BB0821E6569BF8A086114E828DA05CAC529'
    }
mysql_grant { 'wordpress@localhost/wordpress.*':
  ensure     => 'present',
  options    => ['GRANT'],
  privileges => ['ALL'],
  table      => '*.*',
  user       => 'wordpress@localhost',
}
}

class {'woocommerce-mysql':
}
class itblog-mysql {
mysql_database { 'itblog':
  ensure  => 'present',
  charset => 'utf8',
  collate => 'utf8_czech_ci',
}
    mysql_user { 'itblog@localhost':
	ensure  => 'present',
  password_hash   => '*C2A65BB0821E6569BF8A086114E828DA05CAC529'
    }
mysql_grant { 'itblog@localhost/itblog.*':
  ensure     => 'present',
  options    => ['GRANT'],
  privileges => ['ALL'],
  table      => '*.*',
  user       => 'itblog@localhost',
}
}

class {'itblog-mysql':
}
class jogablog-mysql {
mysql_database { 'jogablog':
  ensure  => 'present',
  charset => 'utf8',
  collate => 'utf8_czech_ci',
}
    mysql_user { 'jogablog@localhost':
	ensure  => 'present',
  password_hash   => '*C2A65BB0821E6569BF8A086114E828DA05CAC529'
    }
mysql_grant { 'jogablog@localhost/jogablog.*':
  ensure     => 'present',
  options    => ['GRANT'],
  privileges => ['ALL'],
  table      => '*.*',
  user       => 'jogablog@localhost',
}
}

class {'jogablog-mysql':
}
