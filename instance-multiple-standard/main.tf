//TODO: add an option to disable multi zones?

resource "google_compute_instance" "instance-multiple-standard" {
  name          = "${var.name}-${count.index + 1}"
  count         = "${var.number_of_instance}"
  machine_type  = "${var.machine_type}"
  zone          = "${data.google_compute_zones.default.names
                    [count.index % length(data.google_compute_zones.default.names)]}"

  "boot_disk" {
    auto_delete = true

    initialize_params {
      size      = "${var.boot_disk-size}"
      type      = "${var.boot_disk-type}"
      image     = "${var.image}"

    }
  }

  "network_interface" {
    subnetwork  = "${var.subnetwork}"
  }

  tags          = ["${var.tags}"]

  service_account {
    email  = "${var.service_account-email}"
    scopes = "${var.service_account-scope}"
  }

  allow_stopping_for_update = true

}