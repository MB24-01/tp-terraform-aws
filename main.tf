provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "lab-s3-mimid-bennani-2026-v5"
}


resource "aws_s3_object" "upload_test" {
  bucket = aws_s3_bucket.demo_bucket.id # On fait référence au bucket créé plus haut
  key    = "test-file.txt"              # Le nom du fichier une fois dans S3
  source = "test-file.txt"              # Le chemin vers ton fichier sur ton Mac
  
  # Optionnel mais recommandé : permet de voir si le contenu a changé
  etag = filemd5("test-file.txt")
}
