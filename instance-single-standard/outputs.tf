
output "instance-self_link" {
  value = ["${google_compute_instance.instance-single-standard.*.self_link}"]
}