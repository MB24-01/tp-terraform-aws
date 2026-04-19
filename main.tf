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

# 1. Désactiver le "Block Public Access" (le verrou de sécurité global du bucket)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 2. Créer une politique (Policy) pour autoriser tout le monde à lire (GetObject)
resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.demo_bucket.id

  # On attend que le blocage public soit désactivé avant d'appliquer la politique
  depends_on = [aws_s3_bucket_public_access_block.public_access]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.demo_bucket.arn}/*"
      },
    ]
  })
}

# 3. Ajouter un Output pour obtenir l'URL directement dans ton terminal
output "file_url" {
  value = "https://${aws_s3_bucket.demo_bucket.bucket}.s3.amazonaws.com/${aws_s3_object.upload_test.key}"
}
