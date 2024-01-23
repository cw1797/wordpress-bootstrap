class cheikh_webserver {
  include cheikh_webserver::nginx::install
  include cheikh_webserver::nginx::configure
  include cheikh_webserver::nginx::firewall
  include cheikh_webserver::nginx::service
}
