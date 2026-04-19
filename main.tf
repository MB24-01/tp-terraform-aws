provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "lab-s3-mimid-bennani-2026-v5"
}
