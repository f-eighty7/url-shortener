variable "admin_ip" {
  type        = string
  description = "The public IP address allowed to SSH into the EC2 instance"
}

variable "db_password" {
  type        = string
  description = "The password for the PostgreSQL database"
  sensitive   = true
}

variable "docker_image" {
  type        = string
  description = "The Docker image to pull and run on the EC2 instance"
}