//TODO: add an option to disable multi zones?

resource "google_compute_instance" "instance-multiple-datadisk" {
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

  attached_disk {
    source = "${element(google_compute_disk.instance-multiple-datadisk-disk.*.self_link, count.index)}"
  }

  "network_interface" {
    subnetwork  = "${var.subnetwork}"
  }

  tags          = "${var.tags}"
  metadata      = "${var.metadata}"

  service_account {
    email  = "${var.service_account-email}"
    scopes = "${var.service_account-scope}"
  }

  allow_stopping_for_update = true

}

resource "google_compute_disk" "instance-multiple-datadisk-disk" {
  name        = "${var.name}-${count.index + 1}-datadisk"
  count       = "${var.number_of_instance}"
  size        = "${var.datadisk-size}"
  type        = "${var.datadisk-type}"
  zone        = "${data.google_compute_zones.default.names
                  [count.index % length(data.google_compute_zones.default.names)]}"

  labels {
    managed-by = "terraform"
  }

}