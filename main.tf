// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
  name         = "${var.name}"
  machine_type = "f1-micro"
  zone         = "${var.region_zone}"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -qq install python python-apt -y", // Need python for ansible
    ]

    connection {
        host        = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
        type        = "ssh"
        user        = "${var.ssh_user}"
        private_key = "${file("${var.private_key_path}")}"
        timeout     = "1m"
    }
  }


  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${var.ssh_user}' -i ansible/inventory/gce.py --private-key ${var.private_key_path} ansible/main.yml -e hostname=${var.name} -e user=${var.ssh_user}"
  }
}

resource "google_compute_firewall" "default" {
  name    = "web-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8000"]
  }
}
