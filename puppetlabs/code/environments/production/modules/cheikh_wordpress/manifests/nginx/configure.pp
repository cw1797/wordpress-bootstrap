class cheikh_webserver::nginx::configure {

  file { '/var/www':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }

  file { '/var/www/html':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }

  file { '/var/www/html/index.html':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => file("${module_name}/nginx/index.html"),
    # content => template("${module_name}/index.html.erb"),
  }

  file { '/etc/nginx' :
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/ssl/private/agent.pmx.cloud.key':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    # content => lookup(passwords::hellocheikh_privkey::root),
  }

  file { '/etc/ssl/certs/agent.pmx.cloud.crt':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    # content => file("${module_name}/ssl/privkey.pem"),
  }

  file { '/etc/nginx/conf.d/options-ssl-nginx.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => file("${module_name}/ssl/options-ssl-nginx.conf"),
  }

  file { '/etc/ssl/certs/dhparam.pem':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    # content => file("${module_name}/ssl/dhparam.pem"),
  }

  file { '/etc/nginx/nginx.conf' :
    ensure  => file,
    notify  => Service['nginx'],
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => file("${module_name}/nginx/nginx.conf"),
  }
}
