class planet {
  include ::logrotate

  package { 'planet-venus':
    ensure => present,
  }

  file { '/srv/planet':
    ensure => directory,
  }

  file { '/var/lib/planet':
    ensure => directory,
  }

  file { '/var/log/planet':
    ensure => directory,
  }

  logrotate::file { "${name}.log":
    log     => "/var/log/planet/${name}.log",
    options => [
                'compress',
                'copytruncate',
                'missingok',
                'rotate 7',
                'daily',
                'notifempty',
                ],
  }

}

# vim:sw=2:ts=2:expandtab:textwidth=79
