terraform {
  backend "s3" {
    bucket = "my-terraform-backend-files"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
