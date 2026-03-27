output "bucket_id" {
  description = "L'identifiant unique du bucket S3 créé"
  value       = aws_s3_bucket.demo_bucket.id
}
