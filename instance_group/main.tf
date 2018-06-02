variable "name" {}

variable "instances" {
  type = "list"
}

variable "named_port-port" {
  default = 80
}

variable "named_port-name" {
  default = "http-80"
}

resource "google_compute_instance_group" "instance_group" {
  name = "${var.name}"

  instances = ["${var.instances}"]

  named_port {
    name = "${var.named_port-name}"
    port = "${var.named_port-port}"
  }

}

