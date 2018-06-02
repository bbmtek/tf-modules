
output "instance-self_link" {
  value = ["${google_compute_instance.instance-multiple-datadisk.*.self_link}"]
}