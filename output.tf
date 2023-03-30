output "subnet-range-1" {
    value = google_compute_subnetwork.network-with-ip-ranges.ip_cidr_range
}

output "subnet-range-2" {
    value = google_compute_subnetwork.network-with-ip-ranges-1.ip_cidr_range
  
}

output "project-id" {
    value = google_compute_network.vpc_network.project
  
}