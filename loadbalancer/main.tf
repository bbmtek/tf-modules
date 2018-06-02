variable "name" {}

variable "health_checks" {
  type              = "list"
}

variable "instance_group" {}

variable "ssl_certificate" {}

variable "firewall-network" {}
variable "firewall-target_tags" {
  type              = "list"
}

variable "port_name" {}

resource "google_compute_backend_service" "backend_service" {
  name              = "${var.name}"

  health_checks     = ["${var.health_checks}"]

  backend {
    group           = "${var.instance_group}"
  }
  port_name         = "${var.port_name}"
}

resource "google_compute_url_map" "url_map" {
  name              = "${var.name}"

  default_service   = "${google_compute_backend_service.backend_service.self_link}"
}

resource "google_compute_target_https_proxy" "target_https_proxy" {
  name              = "${var.name}"

  ssl_certificates  = ["${var.ssl_certificate}"]
  url_map           = "${google_compute_url_map.url_map.self_link}"
}

resource "google_compute_global_address" "global_address" {
  name              = "${var.name}"
}

resource "google_compute_global_forwarding_rule" "default" {
  name              = "${var.name}"

  target            = "${google_compute_target_https_proxy.target_https_proxy.self_link}"
  ip_address        = "${google_compute_global_address.global_address.address}"
  port_range        = "443"
  depends_on        = ["google_compute_global_address.global_address"]

}

resource "google_compute_firewall" "firewall" {
  name          = "${var.name}"
  network       = "${var.firewall-network}"
  target_tags   = "${var.firewall-target_tags}"
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  allow { // TODO parameterize it
    protocol = "tcp"
    ports = ["8080", "80", "443"]
  }
}