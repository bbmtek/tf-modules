output "health_check-self_link" {
  value = "${google_compute_health_check.hc-http.*.self_link}"
}