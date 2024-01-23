class cheikh_webserver::nginx::install {
  package { 'nginx':
    ensure  => installed,
  }
}
