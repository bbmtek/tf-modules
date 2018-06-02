
resource "google_compute_instance" "instance-single-datadisk" {
  name          = "${var.name}"
  machine_type  = "${var.machine_type}"

  "boot_disk" {
    auto_delete = true

    initialize_params {
      size      = "${var.boot_disk-size}"
      type      = "${var.boot_disk-type}"
      image     = "${var.image}"

    }
  }

  attached_disk {
    source = "${google_compute_disk.instance-single-datadisk-disk.self_link}"
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

resource "google_compute_disk" "instance-single-datadisk-disk" {
  name        = "${var.name}-datadisk"
  size        = "${var.datadisk-size}"
  type        = "${var.datadisk-type}"
  labels {
    managed-by = "terraform"
  }

}


