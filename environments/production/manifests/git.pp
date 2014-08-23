class git-installed {
include git

git::config { 'user.name':
  value => 'Ondrej Mihalyi',
}

git::config { 'user.email':
  value => 'ondrej.mihalyi@gmail.com',
}

}

class {'git-installed':
}