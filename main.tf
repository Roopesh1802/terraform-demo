//create a vpc
resource "google_compute_network" "vpc_network" {
  project                 = "es-devops-sb"
  name                    = var.project-name
  auto_create_subnetworks = false
  mtu                     = 1460
}


//creates firewall rule
resource "google_compute_firewall" "vpc_network" {
  name    = var.firewall-name
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  //source_tags = ["web"]
  target_tags = ["sample"]
  source_ranges = ["0.0.0.0/0"]
}


//create a subnet
resource "google_compute_subnetwork" "network-with-ip-ranges" {
  name          = var.subnet1-name
  ip_cidr_range = var.subnet1-cidr
  region        = var.subnet1-region
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
  
}
resource "google_compute_subnetwork" "network-with-ip-ranges-1" {
  name          = var.subnet2-name
  ip_cidr_range = var.subnet2-cidr
  region        = var.subnet2-region
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
  
}


//creates instance template
resource "google_compute_instance_template" "instance_test" {
  name         = var.template-name
  machine_type = "n1-standard-1"
  tags= ["sample"]

  disk {
    source_image = "centos-7-v20230306"
    disk_size_gb = 20
  }

  network_interface {
    network = var.template-network
    subnetwork = var.template-subnet
    

    # secret default
    access_config {
      network_tier = "PREMIUM"
    }
}
}


//creates instance group
resource "google_compute_autoscaler" "default" {
  name   = var.autoscaler-name
  zone   = var.zone
  target = google_compute_instance_group_manager.test_group.id

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 2
    cooldown_period = 60
  }
}

resource "google_compute_instance_group_manager" "test_group" {
  provider = google

  name = var.instance-group
  zone = var.zone

  version {
    instance_template = google_compute_instance_template.instance_test.id
    name              = "primary"
  }

  target_pools       = [google_compute_target_pool.test_targetpool.id]
  base_instance_name = var.instance-name
  auto_healing_policies {
    initial_delay_sec = 10
    health_check = google_compute_health_check.http-health-check.id
  }
}

resource "google_compute_target_pool" "test_targetpool" {
  name = var.target-pool
}

resource "google_compute_health_check" "http-health-check" {
  name = var.health-check

  timeout_sec        = 10
  check_interval_sec = 10
  healthy_threshold = 2
  unhealthy_threshold = 2

  http_health_check {
    port = 80
  }
}
