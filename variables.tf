variable "project-name" {
    type = string
    default = "vpc-network-1"
}

variable "firewall-name" {
    type = string
    default = "test-firewall"
}

variable "subnet1-name" {
    type = string
    default = "subnet-3"
}

variable "subnet1-cidr" {
    type = string
    default = "10.20.0.0/24"
}

variable "subnet1-region" {
    type = string
    default = "us-central1"
}

variable "subnet2-name" {
    type = string
    default = "subnet-4"
}

variable "subnet2-cidr" {
    type = string
    default = "10.32.0.0/24"
}

variable "subnet2-region" {
    type = string
    default = "us-west1"
}

variable "template-name" {
    type = string
    default = "test-template"
}

variable "instance-group" {
    type = string
    default = "my-igm"
}

variable "instance-name" {
    type = string
    default = "test-sample"
}

variable "autoscaler-name" {
    type = string
    default = "test-autoscaler"
}

variable "zone" {
    type = string
    default = "us-central1-f"
}

variable "target-pool" {
    type = string
    default = "test-targetpool"
}

variable "health-check" {
    type = string
    default = "healthcheck-http"
}

variable "template-network" {
    type = string
    default = "vpc-network-1"
}

variable "template-subnet" {
    type = string
    default = "subnet-3"
}