provider "aws" {
  region                      = "eu-west-1"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  
  # Ces options empêchent Terraform de contacter les serveurs AWS
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  
  # On lui donne un point de contact imaginaire pour éviter le 403
  endpoints {
    sts = "http://localhost:4566"
  }
}
resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.s3_bucket_name
}
