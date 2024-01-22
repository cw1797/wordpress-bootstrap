class cheikh_wordpress {

  package { 'docker':
    ensure => 'present',
  }

  exec { 'download-and-set-permissions-docker-compose':
    path    => ['/bin', '/usr/bin'],
    command => '/usr/bin/curl -SL https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose && /bin/chmod 0755 /usr/local/bin/docker-compose',
    unless  => '/usr/bin/test -f /usr/local/bin/docker-compose',
    require => Package['docker'],
  }

  file { '/root/cw_wordpress/nginx':
    ensure => directory,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  }

  file {'/root/cw_wordpress/Dockerfile':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => file("${module_name}/docker/webserver/Dockerfile"),
  }

  file {'/root/cw_wordpress/nginx/nginx.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => file("${module_name}/docker/webserver/nginx-conf/nginx.conf"),
  }

  file {'/root/cw_wordpress/nginx/options-ssl-nginx.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => file("${module_name}/docker/webserver/nginx-conf/options-ssl-nginx.conf"),
  }

  file { '/root/cw_wordpress/docker-compose.yaml':
    ensure  => file,
    content => file("${module_name}/docker/docker-compose.yaml"),
  }

  # exec { 'run-docker-compose-up':
  #   command => '/usr/local/bin/docker-compose up',
  #   require => Package['docker'],
  #   cwd     => '/root/cw_wordpress',
    # unless  => '/usr/bin/test -f /usr/local/bin/docker-compose',
  # }

}
