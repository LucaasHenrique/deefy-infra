terraform {
  backend "s3" {
    bucket       = "terraform-state-deefy"
    key          = "deefy/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
