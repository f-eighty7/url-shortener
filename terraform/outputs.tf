output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.url-shortener.public_ip
}

output "db_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.url-shortener_db.endpoint
}