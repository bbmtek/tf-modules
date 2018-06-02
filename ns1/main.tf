provider "ns1" {
  apikey = "${var.ns1-apikey}"
}

variable "ns1-apikey" {}
variable "ns1-zone" {}
variable "ns1-record" {}
variable "ns1-answer" {}

resource "ns1_record" "record" {
  domain = "${var.ns1-record}.${var.ns1-zone}"
  zone = "${var.ns1-zone}"
  type = "A"

  ttl = 60

  answers {
    answer = "${var.ns1-answer}"
  }
}