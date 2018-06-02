output "instance_group-self_link" {
  value = "${google_compute_instance_group.instance_group.self_link}"
}

output "instance_group-port_name" {
  value = "${var.named_port-name}"
}