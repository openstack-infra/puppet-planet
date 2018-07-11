include ::planet

planet::site { 'openstack':
  git_url => 'git://git.openstack.org/openstack/openstack-planet',
}

$planet_config = '[Planet]
name            = Planet OpenStack
link            = http://planet.openstack.org/
owner_name      = Monty Taylor
owner_email     = mordred@inaugust.com
output_theme    = classic_fancy
cache_directory = cache
output_dir      = /srv/planet/openstack
feed_timeout    = 20
items_per_page  = 60
future_dates    = ignore_date
log_level       = DEBUG
bill_of_materials:
  images/#{face}

[DEFAULT]
facewidth = 85
faceheight = 85

[http://www.openstack.org/blog/feed/]
name = OpenStack Blog
nick = openstack'

file { '/var/lib/planet/openstack/planet.ini':
  ensure  => present,
  content => $planet_config,
  require => Vcsrepo['/var/lib/planet/openstack'],
}
