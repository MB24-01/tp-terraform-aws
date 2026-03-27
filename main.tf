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

# Instance Web (déjà existante ou à renommer)
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.ec2_instance_type

  tags = {
    Name = "Web-Server-Nginx"
    Role = "Frontend"
  }
}

# NOUVELLE Instance pour la Base de Données
resource "aws_instance" "db_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro" # On peut aussi utiliser une variable ici

  tags = {
    Name = var.db_instance_name
    Role = "Database"
    Env  = "Dev"
  }
}
