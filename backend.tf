terraform {
  backend "s3" {
    bucket = "scloud-terraform"
    key    = "infra/ds920/print.tfstate"
    region = "eu-central-1"
  }
}