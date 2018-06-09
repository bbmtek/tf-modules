
output "instance-self_link" {
  value = ["${google_compute_instance.instance-single-datadisk.*.self_link}"]
}
