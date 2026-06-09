resource "aws_instance" "url-shortener" {
  ami                    = "ami-05ec2ffaee0a0e6d4" # Amazon Linux 2023 kernel-6.1 AMI in eu-north-1
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.url-shortener_public1.id
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  key_name               = "url-shortener-key"
  user_data_replace_on_change = true 

  user_data = <<-EOF
              #!/bin/bash
              # Log user_data execution for troubleshooting
              exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
              
              echo "Starting Docker installation..."
              dnf update -y
              dnf install -y docker
              systemctl start docker
              systemctl enable docker

              echo "Running web application container..."
              docker run -d -p 80:5000 \
                -e DATABASE_URL="postgresql://postgres:${var.db_password}@${aws_db_instance.url-shortener_db.endpoint}/${aws_db_instance.url-shortener_db.db_name}" \
                ${var.docker_image}
              
              echo "Bootstrapping finished."
              EOF

  tags = {
    Name = "url-shortener-instance"
  }
}