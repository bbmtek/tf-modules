
output "instance-self_link" {
  value = ["${google_compute_instance.instance-multiple-standard.*.self_link}"]
}