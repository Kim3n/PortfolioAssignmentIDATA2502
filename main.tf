terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }

  backend "gcs" {
    bucket = "kimandre-example-bucket"
    prefix = "path/to/your/statefile.tfstate"
  }
}

provider "google" {
  credentials = file(var.google_credentials)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "example_instance" {
  name         = "example-instance"
  machine_type = "n1-standard-1"
  zone         = var.zone
  tags         = ["web"]
  metadata_startup_script = file("./install-scripts/install.sh")
  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20231101"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      // Allocate a public IP address to the instance
    }
  }
}

resource "google_compute_firewall" "allow-http" {
  name    = "allow-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}
