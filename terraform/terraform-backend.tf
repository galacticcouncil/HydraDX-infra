terraform {
  backend "s3" {
    bucket = "hydradx-terraform-state"
    key    = "test-terraform-persistent-state"
    region = "eu-west-1"
    profile = "hydradx"
  }
}