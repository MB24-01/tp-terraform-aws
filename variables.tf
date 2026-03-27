variable "ec2_instance_type" {
  description = "Le type d'instance EC2"
  type        = string
  default     = "t2.micro"
}

variable "ec2_instance_name" {
  description = "Le nom de l'instance EC2"
  type        = string
  default     = "MonInstanceAWS"
}

variable "s3_bucket_name" {
  description = "Le nom du bucket S3 (doit être unique)"
  type        = string
  default     = "mon-bucket-terraform-mimid-2026"
}

variable "sg_port" {
  description = "Le port par défaut pour le groupe de sécurité"
  type        = number
  default     = 80
}
variable "db_instance_name" {
  description = "Nom pour l'instance de base de données"
  type        = string
  default     = "DB-Server-Production"
}
