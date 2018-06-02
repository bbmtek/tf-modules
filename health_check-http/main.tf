variable "name" {}

variable "port" {
  default = "80"
}

variable "request_path" {
  default = "/"
}

resource "google_compute_health_check" "hc-http" {
  name = "${var.name}-http"

  http_health_check {
    port          = "${var.port}"
    request_path  = "${var.request_path}"

  }


}
