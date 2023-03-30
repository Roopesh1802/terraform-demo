terraform {
  backend "gcs" {
    bucket = "1-test-bucket-1"
    prefix = "terraform/state"
    
  }
}