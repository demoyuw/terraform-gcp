terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("~/terraform-pj-357514-7d79a4868b57.json")
  project     = "terraform-pj-357514"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "default" {
  name         = "terraform-gcp-vm1"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["terraform", "ubuntu"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "terraform-network"

    access_config {
      // Ephemeral public IP
    }
  }
}
