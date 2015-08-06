Class['origami-inginea'] 
-> Class['origami-inginea-files']

Class['git-installed'] 
-> Class['origami-inginea-files']

# PHP Install extensions
Php::Extension <| |>
  # Configure extensions
  -> Php::Config <| |>
  # Reload webserver
  ~> Service["apache2"]
