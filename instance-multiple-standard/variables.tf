data "google_compute_zones" "default" {
  status = "UP"
}

variable "name" {}
variable "image" {}

variable "number_of_instance" {
  default = 1
}
variable "subnetwork"  {
  default = "default"
}

variable "machine_type"  {
  default = "n1-standard-1"
}

variable "boot_disk-size"  {
  default = "25"
}

variable "boot_disk-type"  {
  default = "pd-ssd"
}

variable "tags" {
  type = "list"
}

variable "service_account-email" {}
variable "service_account-scope" {
  type = "list"
}

variable "metadata" {
  type = "map"

}
