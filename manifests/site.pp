require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx
  include java
  include zsh
  include wget
  include virtualbox
  include clojure
  include tmux
  include docker
  include python
  include skype
  include ansible
  include evernote
  include rabbitmq
  include mongodb
  include elasticsearch

  class { 'vagrant': }

  class { 'intellij':
    edition => 'community',
    version => '14.0.2'
  }

  # Vim and pathogen plugins
  include vim
  vim::bundle { [
    'scrooloose/nerdtree',
    'croaker/mustang-vim',
    'vim-scripts/paredit.vim',
    'edkolev/promptline.vim',
    'kien/rainbow_parentheses.vim',
    'edkolev/tmuxline.vim',
    'bling/vim-airline',
    'tpope/vim-classpath',
    'guns/vim-clojure-static',
    'altercation/vim-colors-solarized',
    'tpope/vim-fireplace',
    'tpope/vim-fugitive',
    'airblade/vim-gitgutter',
    'mhinz/vim-signify',
    'mustache/vim-mustache-handlebars',
    'guns/vim-clojure-highlight'
  ]: }

  # from the stable channel
  include chrome

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  include nodejs::v0_6
  include nodejs::v0_8
  include nodejs::v0_10

  # default ruby versions
  ruby::version { '1.9.3': }
  ruby::version { '2.0.0': }
  ruby::version { '2.1.0': }
  ruby::version { '2.1.1': }
  ruby::version { '2.1.2': }

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}

#
#  DOTFILES
#
repository { 'dotfiles':
  source => 'garycrawford/dotfiles',
  path   => "/Users/${::boxen_user}/.dotfiles"
}
repository { 'oh-my-zsh':
  source => 'robbyrussell/oh-my-zsh',
  path   => "/Users/${::boxen_user}/.oh-my-zsh"
}
file { "/Users/${::boxen_user}/.zshrc":
  ensure  => link,
  target  => "/Users/${::boxen_user}/.dotfiles/zsh/.zshrc",
  require => [ Repository['oh-my-zsh'], Repository['dotfiles'] ]
}
file { "/Users/${::boxen_user}/.vimrc":
  ensure  => link,
  target  => "/Users/${::boxen_user}/.dotfiles/vim/.vimrc",
  require => [ Repository['dotfiles'] ]
}
file { "/Users/${::boxen_user}/.tmux.conf":
  ensure  => link,
  target  => "/Users/${::boxen_user}/.dotfiles/tmux/.tmux.conf",
  require => [ Repository['dotfiles'] ]
}
